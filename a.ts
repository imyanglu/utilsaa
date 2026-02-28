type User = {
    name: string;
}
function update<K extends keyof User>(k:K,value: User[K]){ }