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

	make
		do
			create procedures.make
			io.read_line
			if procedures.load (io.laststring, "Integrantes.csv") then
				print("YESSSSS")
			end

		end

end

