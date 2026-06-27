sealed class SavedAddressesEvents {}

class LoadSavedAddressesEvent extends SavedAddressesEvents {}

class DeleteAddressEvent extends SavedAddressesEvents {
  final String addressId;
  DeleteAddressEvent(this.addressId);
}