
#region build

function apiStructBuild() {
    var _argSize = argument_count;
    var _structBuild = {};
    var _pair;
    for (var _i = 0; _i < _argSize; ++_i) {
        
        _pair = argument[_i];
        _structBuild[$ _pair[0]] = _pair[1];
    }
    return _structBuild;
}

#endregion
