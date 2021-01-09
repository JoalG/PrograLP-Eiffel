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



invariant
	invariant_clause: True -- Your invariant here

end
