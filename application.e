note
	description: "PrograLP-Eiffel application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

--JSON: JSON_ARRAY, JSON_BOOLEAN, JSON_NULL, JSON_NUMBER, JSON_OBJECT, JSON_STRING, JSON_VALUE

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			num : INTEGER
			nombre_entrada: STRING
		   	entrada: PLAIN_TEXT_FILE
		   	salida:  PLAIN_TEXT_FILE
		   	valores: LIST[STRING]
		   	nombre_valores: LIST[STRING]
			tipo_valores: LIST[STRING]
		   	npal: INTEGER
		   	json1: JSON_OBJECT
		   	archivo_actual : JSON_ARRAY
		   	db :DATA_BASE




		do
			--| Add your code here
			create entrada.make_open_read ("Integrantes.csv")
            create salida.make_open_write ("output.txt")
            create json1.make_empty
            create archivo_actual.make_empty
            create db.make


         --   nombre_entrada := ""
           -- io.read_line
           -- nombre_entrada := io.last_string
            -- io.putstring ("Leyendo: "+ nombre_entrada + "%N> ")

			entrada.read_line
			nombre_valores := entrada.last_string.split (';')

			entrada.read_line
			tipo_valores := entrada.last_string.split (';')

			io.putstring (json1.representation + "%N> " )

			print_list (nombre_valores)


           	print_list (tipo_valores)



            from
                entrada.read_line
            until
                entrada.exhausted
            loop
            	valores := entrada.last_string.split (';')
				print_list (valores)
            --	npal := valores.count
              --  salida.put_string (npal.out + " " + entrada.last_string)
               	salida.new_line



				from
					valores.start
					nombre_valores.start
					tipo_valores.start
				until
					valores.off
					or
					nombre_valores.off
					or
					tipo_valores.off
				loop
					if
						valores.item.out.is_equal ("")
					then
						json1.put (void, nombre_valores.item)

					else

						if
							tipo_valores.item.out.is_equal ("B")
						then

							if
								valores.item.out.is_equal ("T")
								or
								valores.item.out.is_equal ("S")
							then
								json1.put_boolean (True, nombre_valores.item )

							else
								json1.put_boolean (FALSE, nombre_valores.item )
							end



						elseif
							tipo_valores.item.out.is_equal ("9")
							or
							tipo_valores.item.out.is_equal ("N")
						then
							json1.put_real (valores.item.to_double, nombre_valores.item )


						else
							json1.put_string (valores.item, nombre_valores.item )
						end

					end







					nombre_valores.forth
					tipo_valores.forth
					valores.forth

				end

				archivo_actual.add (json1)
				create json1.make_empty
                entrada.read_line




            end

            entrada.close
            salida.close
            io.putstring ("Listo %N> ")

				io.read_line
				db.insert_json (archivo_actual, io.last_string )

           


            across db.get_datos as d loop
	        	print (d.item.representation + " %N")
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

end

