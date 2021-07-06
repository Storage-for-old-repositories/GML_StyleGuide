
global.apiArrayFill = "";
show_message(global.apiArrayFill)

#region apiArrayFill
var _array, _arset;

_arset = [1, 5, 2, 2];
_array = apiArrayFill([], _arset);
apiDebugAssert(array_equals(_array, _arset), "apiArrayFill - 0");

_arset = [];
_array = apiArrayFill(_array, _arset);
apiDebugAssert(array_equals(_array, _arset), "apiArrayFill - 1");

_arset = [1, 23, 1];
_array = apiArrayFill(_array, _arset);
apiDebugAssert(array_equals(_array, _arset), "apiArrayFill - 2");

#endregion

#region apiArrayPlace
var _array, _artst;

_array = [1, 4,  2,    8, 1, 5, 13];
_artst = [1, 4, -1, "hi", 1, 5, 13];
apiArrayPlace(_array, 2, -1, "hi");
apiDebugAssert(array_equals(_array, _artst), "apiArrayPlace - 0");


_array = [1, 4, 2, 1];
_artst = _array;
apiArrayPlace(_array, 2);
apiDebugAssert(array_equals(_array, _artst), "apiArrayPlace - 1");

_array = ["mes", [], 0];
_artst = ["mes", [], 0, 0, 0, 0, "hi", 1];
apiArrayPlace(_array, 6, "hi", 1);
apiDebugAssert(array_equals(_array, _artst), "apiArrayPlace - 2");

#endregion

#region apiArrayPlaceExt
var _array, _artst;

_array = [1,   2, 3, 4];
_artst = [-1, -2, 3, undefined, 0];
apiArrayPlaceExt(_array, 0, [-1, -2], 3, undefined, [0]);
apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 0");

_array = [1, 2, 3];
_artst = [1, 2, 3, "hello", -1, -2];
apiArrayPlaceExt(_array, undefined, "hello", [-1, -2]);
apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 1");


_array = [1, 4,  2,    8, 1, 5, 13];
_artst = [1, 4, -1, "hi", 1, 5, 13];
apiArrayPlaceExt(_array, 2, [-1], "hi");
apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 2");

_array = [1, 4, 2, 1];
_artst = _array;
apiArrayPlaceExt(_array, 4);
apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 3");

#endregion

#region apiArrayInsertEmpty
var _array, _artst;

_array = [1, 2, 3, 4];
_artst = [1, 2, 3, 4, 0, 3, 4];
apiArrayInsertEmpty(_array, 2, 3);
apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 0");

_array = [1, 2, 3, 4];
_artst = [1, 2, 3, 4, 1, 2, 3, 4];
apiArrayInsertEmpty(_array, 0, 4);
apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 1");

_array = [1, 2, 3, 4];
_artst = [7, 7, 7, 7, 1, 2, 3, 4];
apiArrayInsertEmpty(_array, 0, 4, 7);
apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 2");

_array = [1, 2, 3, 4];
_artst = [1, 2, 3, 4, 0, 0];
apiArrayInsertEmpty(_array, 4, 2);
apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 3");

_array = [1, 2, 3, 4];
_artst = [1, 2, 3, 4, "z", "z"];
apiArrayInsertEmpty(_array, 4, 2, "z");
apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 4");

_array = [1, 2, 3, 4];
_artst = [1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 10, 11, 12, 13
apiArrayInsertEmpty(_array, 10, 4);
apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 5");

_array = [1, 2, 3, 4];
_artst = ["hi", "hi", 1, 2, 3, 4, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7];
apiArrayInsertEmpty(_array, 10, 6, 7);
apiArrayInsertEmpty(_array, 0, 2, "hi");
apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 6");

#endregion

#region apiArrayUnshift
var _array, _artst, _count;

_array = [1, 2, 3, 4];
_artst = [-1, -2, 1, 2, 3, 4];
_count = apiArrayUnshift(_array, -1, -2);
apiDebugAssert(array_equals(_array, _artst), "apiArrayUnshift - 0");
apiDebugAssert(_count == 2, "apiArrayUnshift - 0._count");

_array = [1, 4, 2, 1];
_artst = _array;
_count = apiArrayUnshift(_array);
apiDebugAssert(array_equals(_array, _artst), "apiArrayUnshift - 1");
apiDebugAssert(_count == 0, "apiArrayUnshift - 1._count");

_array = [1, 2, 3, 4];
_artst = [-1, -2, "sdf", undefined, 1, 2, 3, 4];
_count = apiArrayUnshift(_array, -1, -2, "sdf", undefined);
apiDebugAssert(array_equals(_array, _artst), "apiArrayUnshift - 2");
apiDebugAssert(_count == 4, "apiArrayUnshift - 2._count");

#endregion

#region array_shift



#endregion
