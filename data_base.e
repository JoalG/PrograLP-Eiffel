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
	datos:  HASH_TABLE[JSON_ARRAY,STRING]


	make
	do
		create datos.make (100)


	end


feature
	insert_json(json: JSON_ARRAY;nombre:STRING)
	do
		datos.put (json, nombre)
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


