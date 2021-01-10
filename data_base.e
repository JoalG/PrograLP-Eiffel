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


	make
	do
		create datos.make (100)
		create tipo_datos.make (100)
		create nombre_datos.make (100)

	end


feature
	insert_json(nombres : LIST[STRING] ;tipos : LIST[STRING] ; datos_json: JSON_ARRAY;nombre:STRING)
	do
		datos.put (datos_json, nombre)
		tipo_datos.put (tipos, nombre)
		nombre_datos.put (nombres, nombre)
	end



feature --gets
	get_datos() : HASH_TABLE[JSON_ARRAY,STRING]
		do Result:=datos end

	get_json(key_json : STRING) : JSON_ARRAY
		local default_json:  JSON_ARRAY

		do
			default_json := datos.at (key_json)
			if
				attached default_json
			then
				Result:= default_json
			else
				create default_json.make_empty
				Result:= default_json
			end



		end






end


