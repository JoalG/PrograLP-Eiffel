note
	description: "Summary description for {PROCEDURES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCEDURES

create
	make

feature {NONE} -- Initialization

	data_base : DATA_BASE
	file_manager: FILE_MANAGER


	make


			-- Initialization for `Current'.
		do

			create data_base.make
			create file_manager.make

		end


feature --OPTION 1

	load(name:STRING ; file_name:STRING): BOOLEAN

		local

			entrada: PLAIN_TEXT_FILE

		   	nombre_valores: LIST[STRING]
			tipo_valores: LIST[STRING]
			valores_actuales : LIST[STRING]

			archivo_actual : JSON_ARRAY
			json_temp: JSON_OBJECT
			json_structure : JSON_STRUCTURE



		do
			entrada := file_manager.read_csv_file (file_name)

			create archivo_actual.make_empty


			entrada.read_line
			nombre_valores := entrada.last_string.split (';')

			entrada.read_line
			tipo_valores := entrada.last_string.split (';')

			from
				entrada.read_line
			until
				entrada.exhausted
			loop

				create json_temp.make_empty
				valores_actuales := entrada.last_string.split (';')
				print_list(valores_actuales)


				from
					valores_actuales.start
					nombre_valores.start
					tipo_valores.start
				until
					valores_actuales.off
					or nombre_valores.off
					or tipo_valores.off
				loop
					if valores_actuales.item.out.is_equal ("") then
						json_temp.put (void, nombre_valores.item)

					elseif tipo_valores.item.out.is_equal ("B") then
						if 	valores_actuales.item.out.is_equal ("T")
							or
							valores_actuales.item.out.is_equal ("S") then

							json_temp.put_boolean (True, nombre_valores.item)

						else
							json_temp.put_boolean (False, nombre_valores.item)
						end

					elseif	tipo_valores.item.out.is_equal ("9")
							or
							tipo_valores.item.out.is_equal ("N") then

							valores_actuales.item.replace_substring_all (",", ".")
							json_temp.put_real (valores_actuales.item.to_double, nombre_valores.item)

					else
							json_temp.put_string (valores_actuales.item, nombre_valores.item)


					end

					nombre_valores.forth
					tipo_valores.forth
					valores_actuales.forth

				end
				print(json_temp.representation+"%N")
				archivo_actual.add (json_temp)
				entrada.read_line


			end
			entrada.close
			io.putstring ("Listo %N> ")


			data_base.insert_json (nombre_valores,tipo_valores,archivo_actual,name)

			if attached data_base.get_json (io.last_string) as json_structure_temp  then
				archivo_actual:=json_structure_temp.get_valores
				print("ACA "+ archivo_actual.representation+ "%N")

			end

			Result:= True
		end



feature --OPTION 2
	save (name:STRING ; file_name:STRING)
		local json_array : JSON_ARRAY
		do
			if attached data_base.get_json (name) as json_structure_temp then
				json_array := json_structure_temp.get_valores
				file_manager.write_json (json_array,file_name)
				print("AIUDA BRO")
			else
				print("MAMANDO PICHA")

			end


		end



feature --OPTION 3
	savecsv (name:STRING ; file_name:STRING)
		local json_structure : JSON_STRUCTURE
		do
			if attached data_base.get_json (name) as json_structure_temp then
				json_structure := json_structure_temp
				file_manager.write_csv (json_structure,file_name)
				print("AIUDA BRO")
			else
				print("MAMANDO PICHA")

			end


		end

feature --Opcion 4
	select_op (name1:STRING ; name2:STRING ; atributo:STRING ; valor:STRING )
		local
			json_structure : JSON_STRUCTURE
			new_json_structure: JSON_STRUCTURE
		do
			if attached data_base.get_json (name1) as json_structure_temp then
				across json_structure_temp.get_valores as json_temp loop
				print("Recorriendo el array")

					if attached {JSON_OBJECT} json_temp.item as json_object  then

						print("asccesa al json obj")

					end
				end
			else
				print("MAMANDO PICHA")

			end

		end

feature
	print_list (lista: LIST[STRING])
	do
		print("[")
	    across lista as i loop
	        	print (i.item.out + " , ")
	        end
	        print("]")
	      	print("%N> ")

	end




invariant
	invariant_clause: True -- Your invariant here

end
