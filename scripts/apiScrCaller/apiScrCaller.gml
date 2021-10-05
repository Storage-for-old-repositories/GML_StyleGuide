
API_GML_WARN_ARGS ApiCaller;

function ApiCaller() constructor {
	
	#region __private
	
	self.__lolist = new ApiLListO();
	self.__last   = undefined;
	
	static __fnum = function(_value, _f) {
		
		if (is_numeric(_value)) return (_value == _f);
		return (method_get_index(_value) == _f);
	}
	
	static __fmet = function(_value, _f) {
		
		if (is_numeric(_value)) exit;
		return (method_get_index(_value) == method_get_index(_f) 
			&&  method_get_self(_value)  == method_get_self(_f));
	}
	
	#endregion
	
	static append = function(_f) {
		
		if (self.__last == undefined) {
			self.__last = self.__lolist.insBegin(_f);
		}
		else {
			self.__last = self.__lolist.insAfter(_f, self.__last);
		}
	}
	
	static push = function() {
		
		var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i) self.append(argument[_i]);
	}
	
	static remFst = function(_f) {
		
		var _last;
		if (is_numeric(_f)) {
			
			_last = self.__lolist.remFst(self.__fnum, _f);
		}
		else {
			
			_last = self.__lolist.remFst(self.__fmet, _f);
		}
		
		if (_last != undefined) {
			
			self.__last = _last[0];
		}
	}
	
	static remAll = function(_f) {
		
		if (is_numeric(_f)) {
			self.__last = self.__lolist.remAll(self.__fnum, _f);
		}
		else {
			self.__last = self.__lolist.remAll(self.__fmet, _f);
		}
	}
	
	static exec = function(_arg) {
		
		var _cell = self.__lolist.topBegin();
		while (_cell != undefined) {
			
			_cell[__API_LINK_LIST.VALUE](_arg);
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
	}
	
	static clear = function() {
		
		self.__lolist.clear();
		self.__last = undefined;
	}
	
	static toArray = function() {
		
		return self.__lolist.toArray();
	}
	
	static toString = function() {
		
		return string(self.__lolist);
	}
	
}


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL true;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrCaller"
		);
		
		var _cl = new ApiCaller();
		var _ref = {
			
			num: 0,
			str: "",
		}
		
		var _add_1    = method(_ref, function(_n) { self.num += _n; });
		var _add_10   = method(_ref, function(_n) { self.num += _n * 10; });
		var _add_100  = method(_ref, function(_n) { self.num += _n * 100; });
		var _add_text = method(_ref, function(_s) { self.str += _s; });
		
		_cl.push(_add_1, _add_10, _add_100);
		_cl.exec(1);
		
		apiDebugAssert(
			_ref.num == 111,
			"<apiScrCaller exec 0>"
		);
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

