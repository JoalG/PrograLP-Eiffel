note
	description: "Summary description for {JSON_STRUCTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_STRUCTURE

create
	make

feature {NONE} -- Initialization

	nombre_valores : LIST[STRING]
	tipo_valores : LIST[STRING]
	json_array : JSON_ARRAY

	make (nombres :  LIST[STRING] ; tipos : LIST[STRING] ; valores : JSON_ARRAY)

		do
			nombre_valores := nombres
			tipo_valores := tipos
			json_array := valores

		end

feature
	make_empty
		local
			lista : LINKED_LIST[STRING]
			lista2 : LINKED_LIST[STRING]
			json_a : JSON_ARRAY
		do
			create lista.make
		 	nombre_valores := lista
		 	create lista2.make
			tipo_valores:= lista
			create json_a.make_empty
			json_array:= json_a
		end


feature
	get_nombres : LIST[STRING]
		do Result:= nombre_valores end

	get_tipos :LIST[STRING]
		do Result:= tipo_valores end

	get_valores : JSON_ARRAY
	 	do Result:= json_array end







end
