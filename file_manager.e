note
	description: "Summary description for {FILE_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end



feature -- READ


	read_csv_file (file_name: STRING ): PLAIN_TEXT_FILE

		local
			file : PLAIN_TEXT_FILE
	 	do

	 		create file.make_open_read (file_name)
	 		Result:=file
	 	end



--write csv


--write json

feature
	write_json(json_array :JSON_ARRAY ; file_name: STRING )
		local
			file : PLAIN_TEXT_FILE
			string_json : STRING
	 	do

	 		create file.make_open_write (file_name)
	 		string_json := json_array.representation
	 		string_json.replace_substring_all ("},", "},%N")
	 		string_json.replace_substring_all ("[", "[%N")
	 		string_json.replace_substring_all ("]", "%N]")
	 		file.putstring (string_json)
			file.close

	 	end


feature
	write_csv(json_structure :JSON_STRUCTURE ; file_name: STRING )
		local
			file : PLAIN_TEXT_FILE
			string_csv : STRING
			value_actual : STRING


	 	do
	 		create file.make_open_write (file_name)

	 		--AGREGAR LOS NOMBRES
			string_csv := ""

			across json_structure.get_nombres as nombre loop
				string_csv.append (nombre.item+";")
			end
			string_csv.remove_tail (1)

			file.put_string (string_csv)
			file.new_line

			string_csv := ""

			--AGREGAR LOS TIPOS
			across json_structure.get_tipos as tipos loop
				string_csv.append (tipos.item+";")
			end
			string_csv.remove_tail (1)
			string_csv.replace_substring_all ("N", "9")

			file.put_string (string_csv)


			--AGREGAR LAS FILAS
			across json_structure.get_valores as json_temp loop
				print("Recorriendo el array")
				file.new_line
				string_csv := ""
				if attached {JSON_OBJECT} json_temp.item as json_object  then

					across json_structure.get_nombres as nombre loop

						if attached json_object.item (nombre.item) as json_value then

							value_actual := json_value.representation

							if json_value.is_number then
								value_actual.replace_substring_all (".", ",")
							elseif json_value.is_null then
								value_actual.replace_substring_all ("null", "")

							elseif attached {JSON_BOOLEAN} json_value as v then
								value_actual.replace_substring_all ("true", "S")
								value_actual.replace_substring_all ("false", "N")
							end

							string_csv.append (value_actual)
							string_csv.append (";")


						end

					end

					string_csv.remove_tail (1)
					string_csv.replace_substring_all ("%"", "")




					file.put_string (string_csv)


				end

			end

			file.close



	 	end

invariant
	invariant_clause: True -- Your invariant here

end
