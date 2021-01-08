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

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			nombre_entrada: STRING
		   	entrada: PLAIN_TEXT_FILE
		   	salida:  PLAIN_TEXT_FILE
		   	words: LIST[STRING]
		   	npal: INTEGER

		do
			--| Add your code here
			create entrada.make_open_read ("Integrantes.csv")
            create salida.make_open_write ("output.txt")

            nombre_entrada := ""
            io.read_line
            nombre_entrada := io.last_string
            io.putstring ("Leyendo: "+ nombre_entrada + "%N> ")

            from
                entrada.read_line
            until
                entrada.exhausted
            loop
            	words := entrada.last_string.split (';')
            	npal := words.count
                salida.put_string (npal.out + " " + entrada.last_string)
                salida.new_line
                entrada.read_line
            end

            entrada.close
            salida.close
            io.putstring ("Listo %N> ")
		end

end

