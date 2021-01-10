note
	description: "Summary description for {DATA_BASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_BASE

create
	make



feature {NONE} -- Initialization
	nombre_datos: HASH_TABLE[LIST[STRING],STRING]
	tipo_datos: HASH_TABLE[LIST[STRING],STRING]
	datos:  HASH_TABLE[JSON_ARRAY,STRING]

	datos_structure: HASH_TABLE[JSON_STRUCTURE,STRING]

	make
	do
		create datos.make (100)
		create tipo_datos.make (100)
		create nombre_datos.make (100)
		create datos_structure.make (100)

	end


feature
	insert_json(nombres : LIST[STRING] ;tipos : LIST[STRING] ; datos_json: JSON_ARRAY;nombre:STRING)
	local
		json_structure: JSON_STRUCTURE
	do
		datos.put (datos_json, nombre)
		tipo_datos.put (tipos, nombre)
		nombre_datos.put (nombres, nombre)
		create json_structure.make (nombres, tipos,datos_json)
		datos_structure.put (json_structure, nombre)
	end



feature --gets
	get_datos() : HASH_TABLE[JSON_ARRAY,STRING]
		do Result:=datos end

	get_json(key_json : STRING) : detachable JSON_STRUCTURE
		local
			default_json:  JSON_STRUCTURE

		do
			default_json := datos_structure.at (key_json)
			Result:= default_json
		end






end


