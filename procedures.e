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
			if not attached data_base.get_json (name) then
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
					--print_list(valores_actuales)


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
					--print(json_temp.representation+"%N")
					archivo_actual.add (json_temp)
					entrada.read_line


				end
				entrada.close
				--io.putstring ("Listo %N> ")


				data_base.insert_json (nombre_valores,tipo_valores,archivo_actual,name)

				if attached data_base.get_json (io.last_string) as json_structure_temp  then
					archivo_actual:=json_structure_temp.get_valores
					--print("ACA "+ archivo_actual.representation+ "%N")

				end

				Result:= True
			else
				print("Ya existe una estructura con el nombre "+ name +"%N")
				Result:= False

			end

		end





feature --OPTION 2
	save (name:STRING ; file_name:STRING):BOOLEAN
		local json_array : JSON_ARRAY
		do
			if attached data_base.get_json (name) as json_structure_temp then
				json_array := json_structure_temp.get_valores
				file_manager.write_json (json_array,file_name)
				Result := True
			else
				print("No existe ninguna estructura con el nombre "+name+"%N")
				Result := False

			end


		end



feature --OPTION 3
	savecsv (name:STRING ; file_name:STRING):BOOLEAN
		local json_structure : JSON_STRUCTURE
		do
			if attached data_base.get_json (name) as json_structure_temp then
				json_structure := json_structure_temp
				file_manager.write_csv (json_structure,file_name)
				Result := True
			else
				print("No existe ninguna estructura con el nombre "+name+"%N")
				Result := False
			end


		end

feature --Opcion 4
	select_op (name1:STRING ; name2:STRING ; atributo:STRING ; valor:STRING ):BOOLEAN
		local
			json_structure : JSON_STRUCTURE
			new_json_structure: JSON_STRUCTURE
			archivo_actual : JSON_ARRAY
		do
			if attached data_base.get_json (name1) as json_structure_temp then

				if not attached data_base.get_json (name2) then

					create archivo_actual.make_empty
					across json_structure_temp.get_valores as json_temp loop
					--print("Recorriendo el array")

						if attached {JSON_OBJECT} json_temp.item as json_object  then


							--print("7"+atributo+"7")
							if attached json_object.item (atributo) as atribute then
								--print ("atributo")
								if atribute.representation.is_equal ("%""+valor+"%"") then
									--print ("concuerda ")
									archivo_actual.add (json_object)
								else
									--print ("NOconcuerda ")
								end

							end


						end
					end
					data_base.insert_json (json_structure_temp.get_nombres,json_structure_temp.get_tipos,archivo_actual ,name2)
					Result := True


				else

					print("Ya existe una estructura con el nombre "+ name2 +"%N")
					Result := False
				end

			else
				print("No existe ninguna estructura con el nombre "+name1+"%N")
				Result := False

			end

		end



feature --Opcion 5

	project(name1:STRING ; name2:STRING ; atributos: LIST[STRING]):BOOLEAN
		local
			nombres_valores : LINKED_LIST[STRING]
			tipo_valores : LINKED_LIST[STRING]
			nombres_n1 : LIST[STRING]
			tipos_n1 :  LIST[STRING]
			new_json_obj : JSON_OBJECT
			archivo_actual : JSON_ARRAY

			index : INTEGER

		do
			create nombres_valores.make
			create tipo_valores.make

			if attached {JSON_STRUCTURE}data_base.get_json (name1) as json_structure_temp then
				if not attached data_base.get_json (name2) then

					create archivo_actual.make_empty
					--print("acá llego %N")
					nombres_n1 := json_structure_temp.get_nombres
					tipos_n1 := json_structure_temp.get_tipos
					across atributos as atributo loop

						from
							nombres_n1.start
							tipos_n1.start
						until
							nombres_n1.off
							or
							tipos_n1.off
						loop

							if nombres_n1.item.is_equal (atributo.item) then
								nombres_valores.extend (atributo.item)
								tipo_valores.extend (tipos_n1.item)
							end

							nombres_n1.forth
							tipos_n1.forth

						end

					end

					across json_structure_temp.get_valores as json_temp  loop

						if attached {JSON_OBJECT}json_temp.item as json_object then
							create new_json_obj.make

							across nombres_valores as nombre_val loop
							 	if attached json_object.item (nombre_val.item) as value then
							 		new_json_obj.put (value, nombre_val.item)
							 	end
							end
							archivo_actual.add (new_json_obj)

						end

					end
					data_base.insert_json (nombres_valores, tipo_valores, archivo_actual, name2)
					Result := True

				else
					print("Ya existe una estructura con el nombre "+ name2 +"%N")
					Result := False

				end

			else
					print("No existe ninguna estructura con el nombre "+name1+"%N")
					Result := False
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
