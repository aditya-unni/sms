//@dart=2.9
import 'package:sms/models/resident.dart';
import 'package:sms/services/resident.dart';

class ResProvider {
  ResidentServices _residentServices = ResidentServices();
  ResidentModel _residentModel;

  ResidentModel get residentModel => _residentModel;
}
