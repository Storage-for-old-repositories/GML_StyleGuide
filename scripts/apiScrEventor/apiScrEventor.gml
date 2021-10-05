

function ApiEventor() constructor {
	
	#region __private
	
	self.__map = {};
	
	static __getCaller = function(_key) {
		
		var _caller = self.__map[$ _key];
		if (_caller == undefined) {
			
			_caller = new ApiCaller();
			self.__map[$ _key] = _caller;
		}
		return _caller;
	}
	
	#endregion
	
	static append = function(_key, _f) {
		
		self.__getCaller(_key).append(_f);
	}
	
	static push = function(_key) {
		
		var _cl = self.__getCaller(_key);
		var _argSize = argument_count;
		for (var _i = 1; _i < _argSize; ++_i) 
			_cl.append(argument[_i]);
	}
	
	static clear = function(_key) {
		
		if (is_string(_key)) {
			
			if (variable_struct_exists(self.__map, _key))
				variable_struct_remove(self.__map, _key);
		}
		else {
			
			self.__map = {};
		}
	}
	
	static remFst = function(_key, _f, _index=false) {
		
		var _cl = self.__map[$ _key];
		if (_cl != undefined) {
			
			if (_index && is_method(_f)) _f = method_get_index(_f);
			_cl.remFst(_f);
		}
	}
	
	static remAll = function(_key, _f, _index=false) {
		
		var _cl = self.__map[$ _key];
		if (_cl != undefined) {
			
			if (_index && is_method(_f)) _f = method_get_index(_f);
			_cl.remAll(_f);
		}
	}
	
	static exec = function(_key, _a) {
		
		var _cl = self.__map[$ _key];
		if (_cl != undefined) _cl.exec(_a);
	}
	
	static toArray = function(_key) {
		
		var _cl = self.__map[$ _key];
		if (_cl != undefined) return _cl.toArray();
		return [];
	}
	
}


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrEventor"
		);
		
		var _ref = {
			num: 0	
		}
		
		var _add_1   = method(_ref, function(_n) { self.num += _n; });
		var _add_10  = method(_ref, function(_n) { self.num += _n * 10; });
		var _add_100 = method(_ref, function(_n) { self.num += _n * 100; });
		
		var _eventor = new ApiEventor();
		
		_eventor.push("ev0", _add_1, _add_10, _add_100);
		
		_eventor.exec("ev0");
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion


