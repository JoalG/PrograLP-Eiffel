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


			print("aca si perro")
			start
			print("aca si perro")
			start
			print("aca si perro")
		--	io.read_line
		--	if procedures.load (io.laststring, "Integrantes.csv") then
		--		print("YESSSSS")
		--	end

		end


feature
	start

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

		end

		end



feature

	load_option : BOOLEAN
		do
			Result:=procedures.load (tokens.at (2), tokens.at (3))
		end


end

