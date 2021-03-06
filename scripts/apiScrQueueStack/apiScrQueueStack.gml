

function ApiQS() constructor {

	#region __private
	
	API_MACRO_CONSTRUCTOR_WRAP {
		var _wrap = argument[0];
		self.__ltlist = _wrap.list;
		self.__size   = _wrap.size;
	}
	else
	API_MACRO_CONSTRUCTOR_DEFL {
		self.__ltlist = new ApiLListT();
		self.__size   = 0;
	}
	
	#endregion
	
	static push = function() {
		
		var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i)
			self.__ltlist.insEnd(argument[_i]);
		
		self.__size += _argSize;
	}
	
	static qpush = function() {
		
		var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i)
			self.__ltlist.insBegin(argument[_i]);
		
		self.__size += _argSize;
	}
	
	static top = function() {
		var _value = self.__ltlist.topEnd();
		if (_value != undefined) return _value[__API_LINK_LIST.VALUE];
	}
	
	static pop = function() {
		var _value = self.__ltlist.popEnd();
		if (_value != undefined) {
			
			--self.__size;
			return _value[__API_LINK_LIST.VALUE];
		}
	}
	
	static size = function() {
		return self.__size;	
	}
	
	static indexOf = function(_index, _remove=false) {
		var _value = self.__ltlist.indexOf(_index);
		if (_value != undefined) {
			
			if (_remove) {
				
				--self.__size;
				self.__ltlist.rem(_value);
			}
			return _value[__API_LINK_LIST.VALUE];
		}
	}
	
	static indexOfInv = function(_index, _remove=false) {
		var _value = self.__ltlist.indexOfInv(_index);
		if (_value != undefined) {
			
			if (_remove) {
				
				--self.__size;
				self.__ltlist.rem(_value);
			}
			return _value[__API_LINK_LIST.VALUE];
		}
	}
	
	static pull = function(_index, _f, _data) {
		var _value = 
			(_index > (self.__size div 2)
			? self.__ltlist.indexOfInv(self.__size - _index - 1)
			: self.__ltlist.indexOf(_index));
		if (_value != undefined) {
			
			_index = _value[__API_LINK_LIST.VALUE];
			if (_f(_index, _data)) {
				
				--self.__size;
				self.__ltlist.rem(_value);
				return _index;
			}
		}
	}
	
	static clear = function() {
		self.__size = 0;
		self.__ltlist.clear();
	}
	
	static isEmpty = function() {
		return (self.__size == 0);
	}
	
	static forEach = function(_f, _data) {
		var _cell = self.__ltlist.__fst;
		while (_cell != undefined) {
			
			if (_f(_cell[__API_LINK_LIST.VALUE], _data)) return;
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
	}
	
	static forRemove = function(_f, _data) {
		
		var _val;
		var _cell = self.__ltlist.__fst;
		while (_cell != undefined) {
			
			if (_f(_cell[__API_LINK_LIST.VALUE], _data)) {
				
				self.__ltlist.rem(_cell);
				--self.__size;
			}
			
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
	}
	
	static forCode = function(_f, _data) {
		
		var _val;
		var _cell = self.__ltlist.__fst;
		while (_cell != undefined) {
			
			_val = _f(_cell[__API_LINK_LIST.VALUE], _data);
			if (is_numeric(_val)) {
				if (_val == 0) return;
				
				self.__ltlist.rem(_cell);
				--self.__size;
			}
			
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
	}
	
	static toArray = function() {
		return self.__ltlist.toArray();	
	}
	
	static toClone = function(_f=apiFunctorId, _data) {
		return new ApiQS(
			new __ApiWrap()
				._set("size", self.__size)
				._set("list", self.__ltlist.toClone(_f, _data))
		);
	}
	
}

