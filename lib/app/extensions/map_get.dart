extension DefaultMap<K, V> on Map<K, V> {
  V get(
    K key, [
    V defaultValue,
  ]) {
    if (this != null && this.containsKey(key)) {
      return this[key];
    } else {
      return defaultValue;
    }
  }
}