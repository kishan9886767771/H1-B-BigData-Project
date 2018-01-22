#!/bin/bash 
show_menu()
{
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}**********************H1B APPLICATIONS***********************${NORMAL}"
    echo -e "${MENU}${NUMBER} 1) ${MENU} Is the number of petitions with Data Engineer job title increasing over time?${NORMAL}"
    echo -e "${MENU}${NUMBER} 2) ${MENU} Find top 5 job titles who are having highest growth in applications. ${NORMAL}"
    echo -e "${MENU}${NUMBER} 3) ${MENU} Which part of the US has the most Data Engineer jobs for each year? ${NORMAL}"
    echo -e "${MENU}${NUMBER} 4) ${MENU} find top 5 locations in the US who have got certified visa for each year.${NORMAL}"
    echo -e "${MENU}${NUMBER} 5) ${MENU} Which industry has the most number of Data Scientist positions?${NORMAL}"
    echo -e "${MENU}${NUMBER} 6) ${MENU} Which top 5 employers file the most petitions each year? ${NORMAL}"
    echo -e "${MENU}${NUMBER} 7) ${MENU} Find the most popular top 10 job positions for H1B visa applications for each year?${NORMAL}"
    echo -e "${MENU}${NUMBER} 8) ${MENU} Find the percentage and the count of each case status on total applications for each year. Create a graph depicting the pattern of All the cases over the period of time.${NORMAL}"
    echo -e "${MENU}${NUMBER} 9) ${MENU} Create a bar graph to depict the number of applications for each year${NORMAL}"
    echo -e "${MENU}${NUMBER} 10) ${MENU}Find the average Prevailing Wage for each Job for each Year (take part time and full time separate) arrange output in descending order${NORMAL}"
    echo -e "${MENU}${NUMBER} 11) ${MENU} Which are employers who have the highest success rate in petitions more than 70% in petitions and total petions filed more than 1000?${NORMAL}"
    echo -e "${MENU}${NUMBER} 12) ${MENU} Which are the top 10 job positions which have the  success rate more than 70% in petitions and total petitions filed more than 1000? ${NORMAL}"
    echo -e "${MENU}${NUMBER} 13) ${MENU}Export result for option no 12 to MySQL database.${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    read opt
}
function option_picked() 
{
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE="$1"  #modified to post the correct option selected
    echo -e "${COLOR}${MESSAGE}${RESET}"
}
clear
start-all.sh | zenity --progress --width 150 --title="Hadoop Services Starting" --pulsate --auto-close #--percentage
yad --info --title="Project" --text '<span foreground="red" font="14">\t\t\tWelcome To BigData Project\n</span><span font="12">\n<b>\tAnalysis And Summarization Of H1B Applicants</b>\n</span>' --width=450 --height=10 --button="gtk-cancel:252" --button="gtk-ok:0" --center --timeout 3
show_menu


while [ opt != '' ]
do
	if [[ $opt = "" ]]; then 
            exit;
    	else
    	#start-dfs.sh
    	#start-yarn.sh
    	#Pig/start-jobhistory.sh
    	#sleep 6
    	
        case $opt in
		1) clear;
			option_picked "1) Is the number of petitions with Data Engineer job title increasing over time?";
			#(cd MapReduce/src/analysis1/analysis1.sh)
			hadoop fs -rmr /niit/projout1
			hadoop fs -rmr /niit/projout1
			rm -r /home/hduser/h1bproject/projectout/1a
			hadoop jar /home/hduser/h1bproject/proj.jar project/DataEngineerJob /niit/h1b/0* /niit/projout1 | zenity --progress --pulsate --title="Job Running" --auto-close
			echo -e "\n1a) Is the number of petitions with Data Engineer job title increasing over time?\n\n"
			hadoop fs -get /niit/projout1 /home/hduser/h1bproject/projectout/1a
			hadoop fs -cat /niit/projout1/p*
			sleep 5			
			show_menu;
		;;
		2) clear;
			option_picked "2) Find top 5 job titles who are having highest growth in applications. ";
			rm -r /home/hduser/h1bproject/projectout/1b			
			pig -x local /home/hduser/h1bproject/pig/h1b1b.pig | zenity --progress --title="Pig Job Running" --pulsate --auto-close
			echo -e "\n1b) Find top 5 job titles who are having highest growth in applications.?\n\n "
			cat /home/hduser/h1bproject/projectout/1b/p*
			sleep 5
			show_menu;
		;;  
		3) clear;
			while : ; do			
			option_picked "3) Which part of the US has the most Data Engineer jobs for each year?\n";
			#echo -e "Do you wish to see \n1. The entire result \n2. Year wise result\n"
			#echo -e "choose option 1 or 2 \n"
			#read choice
			choice=$(yad --title "Result Selection" --entry --text '<span foreground="red" font="14">Do you wish to see 1. The entire result 2. Year wise result\n</span><span font="12">\n<b>choose option 1 or 2 </b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
		#	while ([ $choice != '1'] || [ $choice != '2']) ;
		#	
		#		echo -e "Do you wish to see 1. The entire result \n2. Year wise result\n"
		#		read 'choose option 1 or 2 ' choice				
				case $choice in
				1) clear;				
					hadoop fs -rmr /niit/out2a2 
					rm -r /home/hduser/h1bproject/projectout/2a
					hadoop jar /home/hduser/h1bproject/proj.jar project/WorksiteUSDataEngineerJob /niit/h1b/0* /niit/out2a2 ALL | zenity --progress --title="Pig Job Running" --pulsate --auto-close
					hadoop fs -get /niit/out2a2 /home/hduser/h1bproject/projectout/2a
					echo -e "\n2a) Which part of the US has the most Data Engineer jobs for every year?\n"
					hadoop fs -cat /niit/out2a2/p*
					sleep 5
					break
				;;
				2) clear;
					echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
					rm -r /home/hduser/h1bproject/projectout/2a2
					#read year
					year=$(yad --title "Year Selection" --entry --text '<span foreground="red" font="14">Enter the year (2011,2012,2013,2014,2015,2016)\n</span><span font="12">\n<b>choose any each year</b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
										hive -f /home/hduser/h1bproject/hive/h1b2a.sql -hiveconf year=$year | zenity --progress --title="Hive Job Running" --pulsate --auto-close
					echo -e "\n2a) Which part of the US has the most Data Engineer jobs for each year?\n"
					cat /home/hduser/h1bproject/projectout/2a2/0*
					sleep 5
					break
			#done  
				;;
				*) clear;
				echo -e "Error Command...\n"
				sleep 2
				;;
				esac
				done
			show_menu;
		;;
		4) clear;
			option_picked "4) find top 5 locations in the US who have got certified visa for each year.";
			rm -r /home/hduser/h1bproject/projectout/2b
			pig -x local /home/hduser/h1bproject/pig/h1b2b.pig | zenity --progress --title="Pig Job Running" --pulsate --auto-close
			echo -e "\n2b) find top 5 locations in the US who have got certified visa for each year.\n"
			cat /home/hduser/h1bproject/projectout/2b/p*
			sleep 5
			show_menu;
		;;  
		5) clear;
			option_picked "5) Which industry has the most number of Data Scientist positions?";
			rm -r /home/hduser/h1bproject/projectout/3
			hive -f /home/hduser/h1bproject/hive/h1b3.sql | zenity --progress --title="Hive Job Running" --pulsate --auto-close
			echo -e "\n3) Which industry has the most number of Data Scientist positions?\n"
			cat /home/hduser/h1bproject/projectout/3/0*
			sleep 5
			show_menu;
		;;
		6) clear;
			option_picked "6)Which top 5 employers file the most petitions each year?";
			rm -r /home/hduser/h1bproject/projectout/4			
			pig -x local /home/hduser/h1bproject/pig/h1b4.pig | zenity --progress --title="Pig Job Running" --pulsate --auto-close
			echo -e "\n4)Which top 5 employers file the most petitions each year?\n"
			cat /home/hduser/h1bproject/projectout/4/p*
			sleep 5	
			show_menu;
		;;
		7) clear;
			option_picked "7) Find the most popular top 10 job positions for H1B visa applications for each year?";
			#echo -e "For All Applications Select 1 or For Certified Applications Select 2"
			#read sel
			sel=$(yad --title "Application Selection" --entry --text '<span foreground="red" font="14">For All Applications Select 1 or For Certified Applications Select 2\n</span><span font="12">\n<b>choose option 1 or 2 </b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
			if [ $sel == '1' ];
			then			
				#echo -e "Do you wish to see 1. The entire result \n2. Year wise result\n"
				#read choice
				choice=$(yad --title "Result Selection" --entry --text '<span foreground="red" font="14">Do you wish to see 1. The entire result 2. Year wise result\n</span><span font="12">\n<b>choose option 1 or 2 </b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
				#while [$choice != '1'] || [$choice != '2']
				#do
				#	echo -e "Do you wish to see 1. The entire result \n2. Year wise result\n"
				#	read 'choose option 1 or 2 ' choice
				#done
				if [ $choice == '1' ];
				then 
					hadoop fs -rmr /niit/projout5a
					rm -r /home/hduser/h1bproject/projectout/5a
					hadoop jar /home/hduser/h1bproject/proj.jar project/Top10JobPositions /niit/h1b/0* /niit/projout5a | zenity --progress --title="Job Running" --pulsate --auto-close
					hadoop fs -get /niit/projout5a /home/hduser/h1bproject/projectout/5a
					echo -e "\n5a) Find the most popular top 10 job positions for H1B visa applications for every year?\n"
					hadoop fs -cat /niit/projout5a/p*
					sleep 5
				else
					#echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
					#read year
					year=$(yad --title "Year Selection" --entry --text '<span foreground="red" font="14">Enter the year (2011,2012,2013,2014,2015,2016)\n</span><span font="12">\n<b>choose any each year</b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
					rm -r /home/hduser/h1bproject/projectout/5a1
					hive -e "insert overwrite local directory '/home/hduser/h1bproject/projectout/5a1' row format delimited FIELDS TERMINATED BY '\t' select job_title,year,count(case_status) as temp from h1b.h1b_final where year= '$year' group by job_title,year order by temp desc limit 10;" | zenity --progress --title="Hive Job Running" --pulsate --auto-close
					#hive -f /home/hduser/h1bproject/hive/h1b5a.sql -hiveconf year=$year
					echo -e "\n5a) Find the most popular top 10 job positions for H1B visa applications for each year?\n";
					cat /home/hduser/h1bproject/projectout/5a1/0*
					sleep 5
				fi
			else 
				#echo -e "Do you wish to see 1. The entire result \n2. Year wise result\n"
				#echo -e "choose option 1 or 2"
				#read choice
				choice=$(yad --title "Result Selection" --entry --text '<span foreground="red" font="14">Do you wish to see 1. The entire result 2. Year wise result\n</span><span font="12">\n<b>choose option 1 or 2 </b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
				if [ $choice == '1' ];
				then 
					hadoop fs -rmr /niit/projout5b
					rm -r /home/hduser/h1bproject/projectout/5b
					hadoop jar /home/hduser/h1bproject/proj.jar project/Top10CertifiedJobPositions /niit/h1b/0* /niit/projout5b | zenity --progress --title="Job Running" --pulsate --auto-close
					hadoop fs -get /niit/projout5b /home/hduser/h1bproject/projectout/5b
					echo -e "\n5b) Find the most popular top 10 certified job positions for H1B visa applications for every year?\n";
					hadoop fs -cat /niit/projout5b/p*
					sleep 5
				else
					#echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
					#read year
					rm -r /home/hduser/h1bproject/projectout/5b1
					year=$(yad --title "Year Selection" --entry --text '<span foreground="red" font="14">Enter the year (2011,2012,2013,2014,2015,2016)\n</span><span font="12">\n<b>choose any each year</b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
			    		#hive -e "select job_title,case_status,year,count(case_status ) as temp from h1b_final where year= '$year' and case_status like 'CERTIFIED' group by job_title,case_status,year order by temp desc limit 10; "
					hive -f /home/hduser/h1bproject/hive/h1b5b.sql -hiveconf year=$year | zenity --progress --title="Hive Job Running" --pulsate --auto-close
					echo -e "\n5b) Find the most popular top 10 certified job positions for H1B visa applications for each year?\n";
					cat /home/hduser/h1bproject/projectout/5b1/0*
					sleep 5
				fi
			fi
		show_menu;
		;;
		8) clear;
			option_picked "8) Find the percentage and the count of each case status on total applications for each year.";
			rm -r /home/hduser/h1bproject/projectout/6
			rm -r /home/hduser/h1bproject/graph/6/data/
			rm /home/hduser/h1bproject/graph/6/h1b6graph.jpeg			
			pig -x local /home/hduser/h1bproject/pig/h1b6.pig | zenity --progress --title="Pig Job Running" --pulsate --auto-close
			echo -e "\n6) Find the percentage and the count of each case status on total applications for each year.\n"
			cat /home/hduser/h1bproject/projectout/6/p*
			sleep 3
			#gnuplot -e "set grid;set title 'Case Status on total applications for each year ';set yrange [0:100];set xrange[2011:2017];set xlabel 'Year';set ylabel 'Percentage';plot '/home/hduser/graph/6/data/filtcer/part-r-00000' u 1:5 w lp t 'CERTIFIED' lt rgb "#8B0000" lw 3 pt 6,"/home/hduser/graph/6/data/filtcerwith/part-r-00000" u 1:5 w lp t 'CERTIFIED-WITHDRAWN' lt rgb "#00008B" lw 3 pt 6,"/home/hduser/graph/6/data/filtden/part-r-00000" u 1:5 w lp t 'DENIED' lt rgb "#808000" lw 3 pt 6,"/home/hduser/graph/6/data/filtwith/part-r-00000" u 1:5 w lp t 'WITHDRAWN' lt rgb "#00FF00" lw 3 pt 6;pause 5;set terminal jpeg;set output '/home/hduser/graph/6/h1b6graph.jpeg';replot;exit gnuplot"
			#try to use gnuplot in file without using gnuplot -e
			gnuplot /home/hduser/h1bproject/graph/6/gnu1.gp
			sleep 2
			show_menu;
		;;
		9) clear;
			option_picked "9) The number of applications for each year";
			rm /home/hduser/h1bproject/graph/7/h1b7.dat
			rm /home/hduser/h1bproject/graph/7/h1b7graph.jpeg
			hive -f /home/hduser/h1bproject/hive/h1b7.sql >> /home/hduser/h1bproject/graph/7/h1b7.dat | zenity --progress --title="Hive Job Running" --pulsate --auto-close
			echo -e "\n7) The number of applications for each year\n"
			cat /home/hduser/h1bproject/graph/7/h1b7.dat
			sleep 3
			#gnuplot -e "set style line 1 lc rgb 'grey30' ps 0 lt 1 lw 2;set style line 2 lc rgb 'grey70' lt 1 lw 2;set style fill solid 1.0 border rgb 'grey30';plot '/home/hduser/graph/h1b7.dat' every ::1 u 0:2:(0.7):xtic(1) w boxes;pause 5;set term png;set terminal png size 400,300;set output '/home/hduser/graph/h1b7graph.png';replot;exit gnuplot"
			gnuplot /home/hduser/h1bproject/graph/7/gnu.gp	
			sleep 2
			show_menu;
		;;
		10) clear;
			option_picked "10) Find the average Prevailing Wage for each Job for each Year (take part time and full time separate) arrange output in descending order";
			#echo "Enter Which Time You Want Part-Time or Full-Time"
			#echo "For Part-Time 'N' or For Full-Time 'Y' "
			#read time
			time=$(yad --title "Time Selection" --entry --text '<span foreground="red" font="14">Enter Which Time You Want Part-Time or Full-Time\n</span><span font="12">\n<b>For Part-Time 'N' or For Full-Time 'Y' </b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
			#echo -e "Do you wish to see \n 1. The entire result \n2. Year wise result\n"
			#echo -e "choose option 1 or 2"
			#read choice
			choice=$(yad --title "Result Selection" --entry --text '<span foreground="red" font="14">Do you wish to see 1. The entire result 2. Year wise result\n</span><span font="12">\n<b>choose option 1 or 2 </b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
			if [ $choice == 1 ];
			then
				rm /home/hduser/h1bproject/pig/piginput8
				rm -r /home/hduser/h1bproject/projectout/8
				echo -e 'time='$time'' > /home/hduser/h1bproject/pig/piginput8
				pig -x local -param_file /home/hduser/h1bproject/pig/piginput8 -f /home/hduser/h1bproject/pig/h1b8.pig | zenity --progress --title="Pig Job Running" --pulsate --auto-close
				echo -e "\n8) Find the average Prevailing Wage for each Job for every Year part and full time and arrange output in descending order\n"
				cat /home/hduser/h1bproject/projectout/8/p*
				sleep 5
			else
				#echo -e "Enter the year (2011,2012,2013,2014,2015,2016)"
				#read year
				year=$(yad --title "Year Selection" --entry --text '<span foreground="red" font="14">Enter the year (2011,2012,2013,2014,2015,2016)\n</span><span font="12">\n<b>choose any each year</b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
				rm /home/hduser/h1bproject/pig/piginput8a
				rm -r /home/hduser/h1bproject/projectout/8a
				echo -e 'time='$time'\nyear='$year'' > /home/hduser/h1bproject/pig/piginput8a
				pig -x local -param_file /home/hduser/h1bproject/pig/piginput8a -f /home/hduser/h1bproject/pig/h1b8a.pig | zenity --progress --title="Pig Job Running" --pulsate --auto-close
				echo -e "\n8) Find the average Prevailing Wage for each Job for each Year part and full time and arrange output in descending order\n"
				cat /home/hduser/h1bproject/projectout/8a/p*
				sleep 5
			fi
			show_menu;
		;;
		11) clear;
			option_picked "11) Which are   employers who have the highest success rate in petitions more than 70% in petitions and total petions filed more than 1000?"
			hadoop fs -rmr /niit/projout9
			rm -r /home/hduser/h1bproject/projectout/9/*
			hadoop jar /home/hduser/h1bproject/proj.jar project/EmployersSuccessRate /niit/h1b/0* /niit/projout9 | zenity --progress --title="Job Running" --pulsate --auto-close
			hadoop fs -get /niit/projout9 /home/hduser/h1bproject/projectout/9/
			echo -e "\n9) Which are   employers who have the highest success rate in petitions more than 70% in petitions and total petions filed more than 1000?\n"
			hadoop fs -cat /niit/projout9/p* 
			sleep 5
			show_menu;
		;;
		12) clear;
			option_picked "12) Which are the top 10 job positions which have the  success rate more than 70% in petitions and total petitions filed more than 1000?"
			hadoop fs -rmr /niit/projout10
			rm -r /home/hduser/h1bproject/projectout/10/*
			hadoop jar /home/hduser/h1bproject/proj.jar project/JobSuccessRate /niit/h1b/0* /niit/projout10 | zenity --progress --title="Job Running" --pulsate --auto-close
			hadoop fs -get /niit/projout10 /home/hduser/h1bproject/projectout/10/ 
			echo -e "\n10) Which are the top 10 job positions which have the  success rate more than 70% in petitions and total petitions filed more than 1000?\n"
			hadoop fs -cat /niit/projout10/p*
			sleep 5
			show_menu;
		;;
		13) clear;
			option_picked "11) Export result for question no 10 to MySql database."			
			#echo "Please enter your MySql database details"
			#read -p 'username: ' user
			#read -sp 'password: ' password
			user=$(yad --title "MYSQL Details" --entry --text '<span foreground="red" font="14">Please enter your MySql database details</span><span font="12">\n<b>Enter UserName</b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
			password=$(yad --title "MYSQL Details" --entry --text '<span foreground="red" font="14">Please enter your MySql database details</span><span font="12">\n<b>Enter Password</b>\n</span>' --width=450 --height=100 --center --button="gtk-cancel:252" --button="gtk-ok:0")
			#for above mysql 5.6x set the username and password in login-path
			#mysql -u root -p krrish123
			
			mysql_config_editor set --login-path=local --host=localhost --user=$user --password
			#echo -n $password > /home/hduser/import.txt
			#hadoop fs -rm /user/import.txt
			#hadoop fs -put /home/hduser/import.txt /user/
			mysql --login-path=local -e "create database if not exists project;use project;drop table if exists h1b10;create table h1b10(employee_name varchar(100),total_application int,success_rate varchar(40)); exit;"
			#mysql_config_editor remove --login-path=local
			sqoop export --connect jdbc:mysql://localhost/project --username $user --password-file /user/import.txt --table h1b10 --update-mode allowinsert --update-key employee_name --export-dir /niit/projout10/p* --input-fields-terminated-by '@' ;
			mysql --login-path=local -e "use project;select * from h1b10;"
			sleep 5 
			show_menu;
		;;
		\n) exit;   
		;;
		*) clear;
		option_picked "Pick an option from the menu";
		show_menu;
		;;
        esac
fi
done
