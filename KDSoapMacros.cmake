macro( KDSOAP_GENERATE_WSDL _sources )
  set(KDWSDL2CPP kdwsdl2cpp )
  foreach (_source_FILE ${ARGN})
    get_filename_component(_tmp_FILE ${_source_FILE} ABSOLUTE)
    get_filename_component(_basename ${_tmp_FILE} NAME_WE)
    set(_header_wsdl_FILE ${CMAKE_CURRENT_BINARY_DIR}/wsdl_${_basename}.h)
    set(_source_wsdl_FILE ${CMAKE_CURRENT_BINARY_DIR}/wsdl_${_basename}.cpp)
    
    add_custom_command(OUTPUT ${_header_wsdl_FILE} 
       COMMAND ${KDWSDL2CPP}
       ARGS ${_tmp_FILE} -o ${_header_wsdl_FILE}
       MAIN_DEPENDENCY ${_tmp_FILE}
       DEPENDS ${_tmp_FILE} ${KDWSDL2CPP} )

    add_custom_command(OUTPUT ${_source_wsdl_FILE} 
       COMMAND ${KDWSDL2CPP}
       ARGS -impl ${_header_wsdl_FILE} ${_tmp_FILE} -o ${_source_wsdl_FILE}
       MAIN_DEPENDENCY ${_tmp_FILE} ${_header_wsdl_FILE}
       DEPENDS ${_tmp_FILE} ${KDWSDL2CPP} )

    qt4_wrap_cpp(_sources_MOCS ${_header_wsdl_FILE} ) 
    list(APPEND ${_sources} ${_header_wsdl_FILE} ${_source_wsdl_FILE} ${_sources_MOCS})
  endforeach (_source_FILE)
endmacro(KDSOAP_GENERATE_WSDL _sources )


#/source/travail/kdab/KDSoap/bin/kdwsdl2cpp helloworld.wsdl -o generated/wsdl_helloworld.h
#Converting 0 simple types 
#Converting 0 complex types 
#/source/travail/kdab/KDSoap/bin/kdwsdl2cpp -impl wsdl_helloworld.h helloworld.wsdl -o generated/wsdl_helloworld.cpp

