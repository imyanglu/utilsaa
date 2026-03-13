import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/models/ad_code.dart';
import 'package:plan/common/utils/help.dart';

class Addresspicker extends HookWidget {
  final void Function(Map<String, String>, String adCode) onConfirm;
  final VoidCallback onCancel;
  Addresspicker({required this.onConfirm, required this.onCancel});
  Widget _buildListView(
    List<String> list,
    String? activeItem,
    void Function(String address) onSelect,
  ) {
    final _scrollController = useScrollController();
    return ListView.builder(
      controller: _scrollController,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        final address = list[index];
        final isActive = activeItem == address;
        return Container(
          height: 48,

          alignment: Alignment(0, 0),
          child: GestureDetector(
            onTap: () {
              if (isActive) return;
              onSelect(address);
              _scrollController.animateTo(
                48.0 * index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            child: Text(
              address,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isActive
                    ? Color(0xff6B9D4F)
                    : Color.fromARGB(255, 121, 120, 120),
                fontSize: 14,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final adCodeMap = useState<Map<String, dynamic>?>(null);
    final address = useState<Map<String, String>>({});
    final addressLists = useMemoized(() {
      List<String> provinces = [];
      List<String> cities = [];
      List<String> districts = [];
      if (adCodeMap.value != null) {
        provinces = adCodeMap.value?.keys.toList() ?? [];
        if (address.value['province'] != null) {
          cities =
              adCodeMap.value?[address.value['province']]['children']?.keys
                  .toList() ??
              [];
        }
        if (address.value['city'] != null) {
          districts =
              adCodeMap
                  .value?[address.value['province']]['children']?[address
                      .value['city']]['children']
                  ?.keys
                  .toList() ??
              [];
        }
      }

      return [provinces, cities, districts];
    }, [adCodeMap.value, address.value]);
    print(addressLists[2]);
    init() async {
      print("初始化");
      final json = await loadCityCode();
      adCodeMap.value = json;
      if (adCodeMap.value != null) {
        address.value['province'] = adCodeMap.value?.keys.first ?? '';
      }
    }

    useEffect(() {
      init();
    }, []);
    return Container(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, -3), // 负值让阴影朝上（顶部）
          ),
        ],

        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  onCancel();
                },
                child: Text(
                  "取消",
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 120, 120),
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  String adCode = '';
                  final city =
                      adCodeMap.value?[address
                              .value['province']]['children']?[address
                              .value['city']]
                          as Map<String, dynamic>;
                  if (city.containsKey('children')) {
                    adCode =
                        city['children']?[address.value['district']]?['adCode'];
                  } else {
                    adCode = city['adCode'];
                  }

                  onConfirm(address.value, adCode);
                },
                child: Text(
                  "确认",
                  style: TextStyle(color: Color(0xff6B9D4F), fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildListView(
                    addressLists[0],
                    address.value['province'] ?? null,
                    (ad) {
                      address.value = {'province': ad};
                    },
                  ),
                ),
                Expanded(
                  child: _buildListView(
                    addressLists[1],
                    address.value['city'] ?? null,
                    (ad) {
                      address.value = {
                        'province': address.value['province']!,
                        'city': ad,
                      };
                    },
                  ),
                ),
                Expanded(
                  child: _buildListView(
                    addressLists[2],
                    address.value['district'] ?? null,
                    (ad) {
                      address.value = {
                        'province': address.value['province']!,
                        'city': address.value['city']!,
                        'district': ad,
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
