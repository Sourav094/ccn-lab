BEGIN { }
{	
	if(($11 == "848")) {
		printf "\n %s %s %s %s %s %s %s %s %s %s %s %s",
			$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12;
}
}
END { 
	printf "\n"
}
