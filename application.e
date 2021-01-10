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
			print("Ingrese el comando deseado %N")
			start

		--	io.read_line
		--	if procedures.load (io.laststring, "Integrantes.csv") then
		--		print("YESSSSS")
		--	end

		end


feature
	start

		local
		valor_op4 : STRING
		valores_op5: LIST[STRING]

		do


		io.read_line
		tokens := io.last_string.split (' ')
		procedures.print_list (tokens)


		if tokens.at (1).is_equal ("load") then
			if load_option then
				print("SI LO HIZO ")
			else
				print ("No mae ")
			end

		elseif tokens.at (1).is_equal ("save")  then
			procedures.save (tokens.at (2), tokens.at (3))

		elseif tokens.at (1).is_equal ("savecsv")  then
			procedures.savecsv (tokens.at (2), tokens.at (3))

		elseif tokens.at (1).is_equal ("select") then

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
			print(valor_op4)
			procedures.select_op (tokens.at (2), tokens.at (3), tokens.at (5), valor_op4)



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
			Result:=procedures.load (tokens.at (2), tokens.at (3))
		end


end

