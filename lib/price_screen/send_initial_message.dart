String generateRequestMessage({
  required String providerName,
  required String serviceName,
  required String address,
  required String phone,
  required String contactMethod,
  required String timeSlot,
  required String customerName,
}) {
  return '''
Hi $providerName,

I have just submitted a request for your service: $serviceName.

Here are the details:
📍 Address: $address
📞 Phone: $phone
📬 Preferred Contact: $contactMethod
🕒 Reserved Time Slot: $timeSlot

Looking forward to see you!
- $customerName
''';
}
