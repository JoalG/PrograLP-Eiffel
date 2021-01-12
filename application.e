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

	procedures : PROCEDURES
	tokens : LIST[STRING]


	make
		do
			create procedures.make


			print("Bienvenido al sistema JSON-CSV %N")
			print("Autor: Jose Alfredo Gamboa Roman 2019196401 %N")
			start

		--	io.read_line
		--	if procedures.load (io.laststring, "Integrantes.csv") then
		--		print("YESSSSS")
		--	end

		end


feature
	start

		local
		resultado : BOOLEAN

		do

		print("%NIngrese el comando deseado %N>")
		io.read_line
		tokens := io.last_string.split (' ')
		--procedures.print_list (tokens)

		resultado:=False

		if tokens.at (1).is_equal ("load") then
			resultado := load_option

		elseif tokens.at (1).is_equal ("save")  then
			resultado := save_option

		elseif tokens.at (1).is_equal ("savecsv")  then
			resultado := savecsv_option

		elseif tokens.at (1).is_equal ("select") then
			resultado := select_option


		elseif tokens.at (1).is_equal ("project") then

			resultado := project_option
		end

		if resultado then
			print("Comando ejecutado exitosamente %N")
		else
			print("Comando rechazado %N")

		end

		if not tokens.at (1).is_equal ("salir") then
			start
		else
			print("Gracias por usar el sistema.")
		end



		end



feature

	load_option : BOOLEAN
		do
			Result := procedures.load (tokens.at (2), tokens.at (3))
		end

feature

	save_option: BOOLEAN
		do
			Result := procedures.save (tokens.at (2), tokens.at (3))
		end

feature

	savecsv_option: BOOLEAN
		do
			Result := procedures.savecsv (tokens.at (2), tokens.at (3))
		end



feature

	select_option : BOOLEAN
		local
			valor_op4 : STRING
		do
			valor_op4 := ""
			tokens.move (5)
			from
				tokens.forth
			until
				tokens.off
			loop

				valor_op4.append (tokens.item + " ")

				tokens.forth
			end
			valor_op4.remove_tail (1)
			--print(valor_op4)

			Result := procedures.select_op (tokens.at (2), tokens.at (3), tokens.at (4), valor_op4)
		end


feature
	project_option : BOOLEAN
		local
			valores_op5 : LINKED_LIST[STRING]
		do
			create valores_op5.make
			tokens.move (3)
		--	procedures.print_list (tokens)
			from
				tokens.forth
			until
				tokens.off
			loop
				valores_op5.extend (tokens.item)
				tokens.forth
			end

			--procedures.print_list (valores_op5)

			result := procedures.project (tokens.at (2), tokens.at (3), valores_op5)
		end


end

