#!/usr/bin/awk -f

# For lines that look like this:
# E	206	orange	362	l=ab;q=bb  	732
# print
# E 	206	orange	362	732	568	
#						l=ab
#				 		q=bb

BEGIN { printf ("\n\n%s\n", "Separate fields like a=aa;b=cc onto separate lines.");
	printf ("%s", "L");
	printf ("\t%s", "CODE");
	printf ("\t%s", "WORD");
	printf ("\t%s", "NUM2");
	printf ("\t%s", "SUM");
	printf ("\t%s\n","VARiable_line")
      }

# RUN THROUGH THE LINES
# NR is the number of the record, row, or line that is being processed.
# Since sample3.log has a header row, I'm skipping line 1 with
# if (NR > 1)
{	if (NR > 1)
	{	
		split($5,flag,/;/);
		print $1 "\t" $2 "\t"  $3 "\t"  $4 "\t"  $2+$5;
		for (i in flag)
			{print "\t\t\t\t\t", flag[i] }
	}
}

END { printf ("\n%s\n\n", "That's all folks!") 
    }
