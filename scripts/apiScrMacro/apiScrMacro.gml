

#macro _ undefined


#macro API_MACRO_ARGUMENT_PACK_READ var __argSize = argument_count;           \
									var __argArrs = array_create(__argSize);  \
									for (var __i = 0; __i < __argSize; ++__i) \
										__argArrs[__i] = argument[__i];                                          

#macro API_MACRO_ARGUMENT_PACK_GET  __argArrs

#macro API_MACRO_UINT16_MAX         65535
#macro API_MACRO_INT32_MAX          2147483647
#macro API_MACRO_INT32_MIN          (-2147483648)

#macro API_MACRO_DEFAULT_CHAR       "▯"


 