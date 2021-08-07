
/*
	Тестируется в "auto_test_array"
*/


#region modify

/// @function apiArrayPlace(array, array_fill)
/// @param array
/// @param array_fill
function apiArrayFill(_array, _arrayFill) {
	var _size = array_length(_arrayFill);
    array_resize(_array, _size);
	array_copy(_array, 0, _arrayFill, 0, _size);
	return _array;
}

/// @function apiArrayPlace(array, [index], ...value);
/// @param array
/// @param [index]
/// @param ...value
function apiArrayPlace(_array, _index) {
	var _count = argument_count - 2;
	if (_count > 0) {
		
		var _size = array_length(_array);
		if (is_undefined(_index)) _index = _size;
		
		array_resize(_array, max(_size, _index + _count));
		for (var _i = 0; _i < _count; ++_i) array_set(_array, _index + _i, argument[_i + 2]);
	}
}

/// @function apiArrayInsertEmpty(array, index, count, [value]);
/// @param array
/// @param index
/// @param count
/// @param [value]
function apiArrayInsertEmpty(_array, _index, _count) {
    if (_count > 0) {
		
        var _length = array_length(_array);
		var _size   = _length - _index;
		var _insert = (_size > 0);
		
        array_resize(_array, max(_length, _index + _count));
		
        if (_insert) {
			
            var shift = _index + _count;
            while (_size--) array_set(_array, _size + shift, array_get(_array, _size + _index));
        }
        if (argument_count > 3) {
            if (_insert) {
                
				while (_count--) array_set(_array, _index + _count, argument[3]);
                return true;
            }
            
			_size = array_length(_array);
            _length -= 1;
            while (++_length < _size) array_set(_array, _length, argument[3]);
        }
        return true;
    }
    return false;
}

/// @function apiArrayShift(array)
/// @param array
function apiArrayShift(_array) {
    if (array_length(_array)) {
		
        var _value = array_get(_array, 0);
        array_delete(_array, 0, 1);
        return _value;
    }
    return undefined;
}

/// @function apiArrayUnshift(array, ...value);
/// @param array
/// @param ...value
function apiArrayUnshift(_array) {
	var _argSize = argument_count;
    if (apiArrayInsertEmpty(_array, 0, _argSize - 1)) {
		
        var _i = 0;
        while (++_i < _argSize) array_set(_array, _i - 1, argument[_i]);
		
		return (_argSize - 1);
    }
	return 0;
}

/// @function apiArrayShuffle(array);
/// @param array
function apiArrayShuffle(_array) {
    var _size = array_length(_array);
    if (_size > 1) {
		
        var _i = -1, _swap, _j;
        while (++_i < _size) {
			
            _j = irandom(_size - 1);
            _swap = array_get(_array, _i);
            array_set(_array, _i, array_get(_array, _j));
            array_set(_array, _j, _swap);
        }
	}
}

/// @function apiArrayCopy(dest, src, dest_index, ?src_index, ?length);
/// @param dest
/// @param src
/// @param dest_index
/// @param ?src_index
/// @param ?length
function apiArrayCopy(_dest, _src, _destIndex, _srcIndex, _length) {
    var _destLength = array_length(_dest);
    var _srcLength = array_length(_src);
    if (is_undefined(_srcIndex)) _srcIndex = 0;
    if (is_undefined(_length)) _length = _srcLength - _srcIndex;
    if (_length > 0) {
		
        array_resize(_dest, max(_destLength, _destIndex + _length));
        if (_dest == _src) {
			
            if (_destIndex == _srcIndex) exit;
            if (_destIndex > _srcIndex) {
            	
            	do {
            		_length -= 1;
            		array_set(_dest, _length + _destIndex, array_get(_src, _length + _srcIndex));
            	} until (_length <= 0);
                exit;
            }
        }
        var _i = 0;
        do {
            array_set(_dest, _i + _destIndex, array_get(_src, _i + _srcIndex));
        } until (++_i == _length);
    }
}

/// @function apiArrayInsert(dest, src, dest_index, ?src_index, ?length);
/// @param dest
/// @param src
/// @param dest_index
/// @param ?src_index
/// @param ?length
function apiArrayInsert(_dest, _src, _destIndex, _srcIndex, _length) {
    var _destLength = array_length(_dest);
    var _srcLength = array_length(_src);
    if (is_undefined(_srcIndex)) _srcIndex = 0;
    if (is_undefined(_length)) _length = _srcLength - _srcIndex;
    if (_length > 0) {
		
        array_resize(_dest, _destLength + _length);
        var _size = _destLength - _destIndex;
        if (_size > 0) {
			
            var _destShift = _destIndex + _length;
            if (_dest == _src) {
				
                var _temp = array_create(_length), _i = -1;
                while (++_i < _length) array_set(_temp, _i,                 array_get(_src, _i + _srcIndex));
                while (_size--)        array_set(_dest, _size + _destIndex, array_get(_dest, _size + _destShift));
                
                _i = -1;
                while (++_i < _length) array_set(_dest, _i + _destIndex,    array_get(_temp, _i));
                exit;
            }
            do {
				_size -= 1;
            	array_set(_dest, _size + _destShift, array_get(_dest, _size + _destIndex));
            } until (_size == 0);
        }
        do {
        	_length -= 1;
        	array_set(_dest, _length + _destIndex, array_get(_src, _length + _srcIndex));
        } until (_length == 0);
    }
}

/// @function apiArrayRemoveNoOrder(array, index);
/// @param array
/// @param index
function apiArrayRemoveNoOrder(_array, _index) {
	var _size = array_length(_array) - 1;
	array_set(_array, _index, array_get(_array, _size));
	array_resize(_array, _size);
}

#endregion

#region build

/// @function apiArrayBuild(...value);
/// @param ...value
function apiArrayBuild() {
	var _argSize = argument_count;
	var _array = array_create(_argSize);
	for (var _i = 0; _i < _argSize; ++_i) array_set(_array, _i, argument[_i]);
	return _array;
}

/// @function apiArrayBuildConcat(...array_or_value);
/// @param ...array_or_value
function apiArrayBuildConcat() {
	var _argSize = argument_count;
	var _build = [];
	if (_argSize > 0) {
		
		var _value, _jsize, _j, _temp, _size = 0;
		for (var _i = 0; _i < _argSize; ++_i) {
			_value = argument[_i];
			
			if (is_array(_value)) {
				
				_jsize = array_length(_value);
				_temp = _size + _jsize;
				
				array_resize(_build, _temp);
				
				for (_j = 0; _j < _jsize; _j++) 
					array_set(_build, _size + _j, _value[_j]);
				
				_size = _temp;
			}
			else {
				
				_size += 1;
				array_push(_build, _value);
			}
		}
	}
	return _build;
}

/// @function apiArrayBuildDup1d(array);
/// @param array
function apiArrayBuildDup1d(_array) {
	var _size = array_length(_array);
	var _build = array_create(_array);
	array_copy(_build, 0, _array, 0, _size);
	return _build;
}

#endregion

#region find

/// @function apiArrayFindIndex(array, value, [index]);
/// @param array
/// @param value
/// @param [index]
function apiArrayFindIndex(_array, _value, _index=0) {
	
	var _size = array_length(_array);
	for (; _index < _size; ++_index)
		if (_array[_index] == _value) return _index;
	
	return -1;
}

/// @function apiArrayExists(array, value);
/// @param array
/// @param value
function apiArrayExists(_array, _value) {
	return (apiArrayFindIndex(_array, _value) != -1);
}

#endregion

#region range

/// @function apiArrayRangeGet(array, index, size);
/// @param array
/// @param index
/// @param size
function apiArrayRangeGet(_array, _index, _length) {
	var _range = [];
	array_copy(_range, 0, _array, _index, _length);
	return _range;
}

/// @function apiArrayRangeSet(array, index, range);
/// @param array
/// @param index
/// @param range
function apiArrayRangeSet(_array, _index, _range) {
	apiArrayCopy(_array, _range, _index);
}

/// @function apiArrayRangeInsert(array, index, range);
/// @param array
/// @param index
/// @param range
function apiArrayRangeInsert(_array, _index, _range) {
	apiArrayInsert(_array, _range, _index);
}

#endregion

