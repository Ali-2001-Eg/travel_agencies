part of "../home.dart";

abstract interface class CityDataSource {
  Future<Either<Failure, List<CityModel>>> getCities();
}

class CityDataSourceImpl implements CityDataSource {
  final GenericDataSource _genericDataSource;
  CityDataSourceImpl(this._genericDataSource);

  @override
  Future<Either<Failure, List<CityModel>>> getCities() {
    return _genericDataSource.fetchData<CityModel>(
        endpoint: Endpoints.cities, fromJson: CityModel.fromJson);
  }
}
