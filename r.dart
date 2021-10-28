import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart' as ffi;

class _Handle extends ffi.Opaque {}

class _PersistentHandle extends ffi.Opaque {}

class _WeakPersistentHandle extends ffi.Opaque {}

class _FinalizableHandle extends ffi.Opaque {}

class _Isolate extends ffi.Opaque {}

class _IsolateData extends ffi.Opaque {}

class _IsolateGroup extends ffi.Opaque {}

class _IsolateGroupData extends ffi.Opaque {}

class DartAPI {
  ffi.DynamicLibrary _library = ffi.DynamicLibrary.executable();
  int Function(ffi.Pointer<_Handle>) IsError;
  int Function() IsPrecompiledRuntime;
  ffi.Pointer<_Handle> Function() Precompile;
  ffi.Pointer<_Isolate> Function() CurrentIsolate;
  ffi.Pointer<_IsolateData> Function() CurrentIsolateData;
  ffi.Pointer<_IsolateGroup> Function() CurrentIsolateGroup;
  ffi.Pointer<_IsolateGroupData> Function() CurrentIsolateGroupData;
  ffi.Pointer<_IsolateData> Function(ffi.Pointer<_Isolate>) IsolateData;
  void Function() ShutdownIsolate;
  DartAPI() {
    IsPrecompiledRuntime =
        _library.lookupFunction<ffi.Int8 Function(), int Function()>(
            "Dart_IsPrecompiledRuntime");
    Precompile = _library.lookupFunction<ffi.Pointer<_Handle> Function(),
        ffi.Pointer<_Handle> Function()>("Dart_Precompile");
    IsError = _library.lookupFunction<ffi.Int8 Function(ffi.Pointer<_Handle>),
        int Function(ffi.Pointer<_Handle>)>("Dart_IsError");
    CurrentIsolate = _library.lookupFunction<ffi.Pointer<_Isolate> Function(),
        ffi.Pointer<_Isolate> Function()>("Dart_CurrentIsolate");
    CurrentIsolateData = _library.lookupFunction<
        ffi.Pointer<_IsolateData> Function(),
        ffi.Pointer<_IsolateData> Function()>("Dart_CurrentIsolateData");
    CurrentIsolateGroup = _library.lookupFunction<
        ffi.Pointer<_IsolateGroup> Function(),
        ffi.Pointer<_IsolateGroup> Function()>("Dart_CurrentIsolateGroup");
    CurrentIsolateGroupData = _library.lookupFunction<
        ffi.Pointer<_IsolateGroupData> Function(),
        ffi.Pointer<_IsolateGroupData>
            Function()>("Dart_CurrentIsolateGroupData");
    IsolateData = _library.lookupFunction<
        ffi.Pointer<_IsolateData> Function(ffi.Pointer<_Isolate>),
        ffi.Pointer<_IsolateData> Function(
            ffi.Pointer<_Isolate>)>("Dart_IsolateData");
    ShutdownIsolate =
        _library.lookupFunction<ffi.Void Function(), void Function()>(
            "Dart_ShutdownIsolate");
  }
}

int main(List<String> args) {
  var dapi = DartAPI();
  var precompile = dapi.Precompile();
  var isPrecompiledRuntime = dapi.IsPrecompiledRuntime();
  var currentIsolate = dapi.CurrentIsolate();
  var currentIsolateData = dapi.CurrentIsolateData();
  var currentIsolateGroup = dapi.CurrentIsolateGroup();
  var currentIsolateGroupData = dapi.CurrentIsolateGroupData();
  var isolateData = dapi.IsolateData(currentIsolate);
  print(precompile);
  print(isPrecompiledRuntime);
  print(currentIsolate);
  print(currentIsolateData);
  print(currentIsolateGroup);
  print(currentIsolateGroupData);
  print(isolateData);
  assert(currentIsolateData == isolateData);
  //  dapi.ShutdownIsolate();
  assert(false);
  return 0;
}
