import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:routing_client_dart/routing_client_dart.dart';

String formatDateString(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
    return formattedDate;
  } catch (e) {
    return dateString;
  }
}

  Future<List<LatLng>> getRealRoadRoute(
    LatLng sourcePoint,
    LatLng destinationPoint,
  ) async {
    try {
      final manager = RoutingManager();

      // Request real driving directions from OSRM public backend
      final result = await manager.getRoute(
        request: OSRMRequest.route(
          waypoints: [
            LngLat(lng: sourcePoint.longitude, lat: sourcePoint.latitude),
            LngLat(
              lng: destinationPoint.longitude,
              lat: destinationPoint.latitude,
            ),
          ],
          geometries: Geometries.polyline,
        ),
      );

      // Extract the detailed street coordinates from the result
      final poiList = result.polyline;

      return poiList?.map((point) => LatLng(point.lat, point.lng)).toList() ??
          [];
    } catch (_) {
      // Fallback to straight line if network or routing fails
      return [sourcePoint, destinationPoint];
    }
  }
