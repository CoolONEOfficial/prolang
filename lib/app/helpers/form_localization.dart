String formLocalizationKey(dynamic model) {
  return model.documentId != null ? 'edit' : 'create';
}
