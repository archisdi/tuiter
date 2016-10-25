program twitter;
uses crt;

type twts = record
     all:string;
     date:string;
end;

type account = record
     nama:string;
     usernm:string;
     pass:string;
     tweet:array[1..100] of twts;
     following:array[1..100] of string;
end;

type twetm = record
	 username:string;
	 all:string;
end;


var
usr:array[1..100] of account;
twtl:array[1..100] of twetm;
usrlg:integer;

procedure sort_tweet_user();
var
i,n,j,k,row,col:integer;
tmp,tmp1:string;
begin
	i:=1;
	while(length(twtl[i].username) <> 0) do
		begin
			twtl[i].username:='';
			twtl[i].all:='';
			i:=i+1;
		end;

	i:=1;
	k:=1;
	n:=1;
	while (length(usr[usrlg].tweet[n].all) <> 0) do
			begin
				twtl[k].username:=usr[usrlg].usernm;
				twtl[k].all:=usr[usrlg].tweet[n].all;
				n:=n+1;
				k:=k+1;
			end;
			
		while (length(usr[usrlg].following[i]) <> 0) do
			begin
				j:=1;
				while (length(usr[j].usernm) <> 0) and (usr[usrlg].following[i] <> usr[j].usernm) do
					j:=j+1;
					n:=1;
				while (length(usr[j].tweet[n].all) <> 0) do
					begin
						twtl[k].username:=usr[j].usernm;
						twtl[k].all:=usr[j].tweet[n].all;
						k:=k+1;
						n:=n+1;
					end;
				i:=i+1;
			end;

	for row:=100 downto 2 do begin
		for col:=2 to row do begin
		
			if(twtl[col-1].username[1] > twtl[col].username[1]) then begin
				
				tmp := twtl[col-1].username;
				twtl[col-1].username := twtl[col].username;
				twtl[col].username := tmp;
				
				tmp1 := twtl[col-1].all;
				twtl[col-1].all := twtl[col].all;
				twtl[col].all := tmp1;
				
				
			end;
		
		end;
	end;
	
	
	i:=1;
	writeln('       Tweets By User        ');
	writeln('=============================');
	while(length(twtl[i].username) <> 0) do
		begin
			writeln(i,'.',twtl[i].all);
			writeln('@',twtl[i].username);
			writeln('++++++++++++++++++++++++++++++++++++++++++');
			i:=i+1;
		end;
	writeln('=============================');	
	readln();
	clrscr;


end;

procedure alltweets();
var
i,j,n,k:integer;
begin
	i:=1;
	k:=1;
	n:=1;
	writeln('            All Tweets             ');
	writeln('===================================');
	while (length(usr[usrlg].tweet[n].all) <> 0) do
		begin
			writeln(k,'.',usr[usrlg].tweet[n].all);
			writeln('@',usr[usrlg].usernm);
			writeln('++++++++++++++++++++++++++++++++++++++++++');
			k:=k+1;
			n:=n+1;
		end;
		
	while (length(usr[usrlg].following[i]) <> 0) do
		begin
			j:=1;
			while (length(usr[j].usernm) <> 0) and (usr[usrlg].following[i] <> usr[j].usernm) do
				j:=j+1;
				n:=1;
			while (length(usr[j].tweet[n].all) <> 0) do
				begin
					writeln(k,'.',usr[j].tweet[n].all);
					writeln('@',usr[j].usernm);
					writeln('++++++++++++++++++++++++++++++++++++++++++');
					k:=k+1;
					n:=n+1;
				end;
			i:=i+1;
		end;
		writeln('===================================');
		readln();
		clrscr;
end;
	
procedure folr();
var
i:integer;
begin
	i:=1;
	writeln('Following and Followers');
	writeln('=======================');
	while(length(usr[usrlg].following[i]) <> 0) do
		begin
			writeln(i,'.',usr[usrlg].following[i]);
			i:=i+1;
		end;
	writeln('=======================');	
	readln();
	clrscr;
end;

procedure mytweets();
var
i:integer;
begin
	i:=1;
	writeln('       My tweets       ');
	writeln('=======================');
	while(length(usr[usrlg].tweet[i].all) <> 0) do
		begin
			writeln(i,'.',usr[usrlg].tweet[i].all);
			i:=i+1;
		end;
	writeln('=======================');	
	readln();
	
	clrscr;
end;

procedure follow(var fol:string);
var
check:boolean;
i,j:integer;
begin
	clrscr;
	i:=1;
	while (length(usr[i].usernm) <> 0) and (usr[i].usernm <> fol) do
		i:=i+1;
		begin
			j:=i;
			i:=1;
			check:=false;
			while (length(usr[usrlg].following[i]) <> 0 ) and (usr[usrlg].following[i] <> fol) do
				i:=i+1;
			if (usr[usrlg].following[i] = fol) then
				check:=true
			else
				check:=false;
			if (fol = '') then
				begin
					clrscr;
					writeln('You must at least enter one character');
					writeln('-------------------------------------');
					readln();
					clrscr;
				end
	
			else if (length(usr[j].usernm) = 0) then
				begin
					writeln('Username not found');
					writeln('==================');
				end
			
			else if (usr[j].usernm = usr[usrlg].usernm) then
				begin
					writeln('You cannot follow your self');
					writeln('===========================');
				end
			
			else if (not check) then
				begin
					i:=1;
					while (length(usr[usrlg].following[i]) <> 0) do
						i:=i+1;
						begin
							usr[usrlg].following[i]:=usr[j].usernm;
							i:=1;
							while (length(usr[j].following[i]) <> 0) do
								i:=i+1;
								begin
									usr[j].following[i]:=usr[usrlg].usernm;	
								end;
					
							writeln('Following ',usr[j].usernm,' ,success');
							writeln('========================');
						end;
				end
				
			else if check then
				begin
					writeln('Username already on your following and followers list');
					writeln('=====================================================');
				end;
		end;
end;

procedure tweets(var all:string);
var
i:integer;

begin
	if (all = '') then
		begin
			clrscr;
			writeln('You must at least enter one character');
			writeln('-------------------------------------');
			readln();
			clrscr;
		end
	else
		begin
			i:=1;
			while (length(usr[usrlg].tweet[i].all) <> 0) do
					i:=i+1;
				begin
					clrscr;
					usr[usrlg].tweet[i].all:=all;
					writeln('Tweeting Success');
					writeln('----------------');
					writeln('Tweet : ',all);
					readln();
					clrscr;
				end;
		end;
end;

procedure find(var src:string);
var
i:integer;

begin
	if (src = '') then
		begin
			clrscr;
			writeln('You must at least enter one character');
			writeln('-------------------------------------');
			readln();
			clrscr;
		end
	else
		begin
			i:=1;
			while (length(usr[i].usernm) <> 0) and (usr[i].usernm <> src) do
					i:=i+1;

				begin
					clrscr;
					if (usr[i].usernm = src) then
						begin
							clrscr;
							writeln('Username Found');
							writeln('========================');
							writeln('Name     : ',usr[i].nama);
							writeln('Username : ',usr[i].usernm);
							writeln('========================');
							readln();
							clrscr;
						end
					else
						begin
							clrscr;
							writeln('Username Not Found');
							writeln('------------------');
							readln();
							clrscr;
						end;
				end;
		end;
end;


procedure main(var usrnm:account);
var
tweet,look:string;
chs:string;
i:integer;
begin
	while (chs <> '8') do
	begin
		writeln('My Name     : ',usr[usrlg].nama);
		writeln('My Username : ',usr[usrlg].usernm);
		writeln('------------------------------------');
		writeln('1. Tweet');
		writeln('2. Follow');
		writeln('3. Find Friend');
		writeln('4. Following and Followers');
		writeln('5. My Tweets');
		writeln('6. All Tweets');
		writeln('7. View Tweets by user');
		writeln('8. Logout');
		writeln();
		write('       Choose: '); readln(chs);
		case chs of
		'1' : begin
				clrscr;
				write('Tweets : '); readln(tweet);
				tweets(tweet);
			  end;
		'2' : begin
				clrscr;
				writeln('  Follow a Friend  ');
				writeln();
				write('Enter Username : '); readln(look);
				follow(look);
			  end;
		'3' : begin
				clrscr;
				writeln('  Search Friend  ');
				writeln();
				write('Enter Username : '); readln(look);
				find(look);
			  end;
		'4' : begin
				clrscr;
				folr();
			  end;
		'5' : begin
				clrscr;
				mytweets();
			  end;
		'6' : begin
				clrscr;
				alltweets();
			  end;
		'7' : begin
				clrscr;
				sort_tweet_user();
			  end;
		'8' : begin
				usrlg:=0;
				clrscr;
			  end;
			  
		''  : begin
				clrscr;
				writeln('Enter your Input');
				writeln('----------------');
			  end;
			  
		else
				clrscr;
				writeln('Input Not Valid !');
				writeln('-----------------');

		end;
	end;
end;


procedure login;
var
pass,user:string;
i:integer;
chs,pil:string;
begin
	clrscr;
	writeln('    Login    ');
	writeln();
	write('Username : '); readln(user);
	write('Password : '); readln(pass);
	
	if (user = '') or (pass = '') then
		begin
			clrscr;
			writeln('All field must be fill');
			writeln('----------------------');
				begin
					write('Retry Login ? (y/n) : '); readln(chs);
					if (chs = 'y') then	
						begin
							clrscr;
							login;
						end
					else if (chs = 'n') then
						begin
							usrlg:=0;
							clrscr;
						end
					else if (chs = '') then
						begin
							clrscr;
							writeln('Enter your input');
							writeln('----------------');
						end
					else
						writeln('Input Not Valid !');
				end;
		end
	else
		begin
			i:=1;
				while (length(usr[i].usernm) <> 0) and (usr[i].usernm <> user) do	
					i:=i+1;
				
				begin	
					clrscr;
					if (usr[i].usernm = user) and (usr[i].pass = pass) then
						begin
							usrlg:=i;
							main(usr[i]);
						end
					
					else if (usr[i].usernm <> user) or (usr[i].pass <> pass) then
						begin
							clrscr;
							writeln('Username or Password is not correct');
							writeln('-----------------------------------');
							begin
								write('Retry Login ? (y/n) : '); readln(pil);
								if (pil = 'y') then	
									begin
										clrscr;
										login;
									end
								else if (pil = 'n') then
									begin
										usrlg:=0;
										clrscr;
									end
								else if (pil = '') then
									begin
										clrscr;
										writeln('Enter your input');
										writeln('----------------');
									end
								else
									writeln('Input Not Valid !');
							end;
						end;
					
				end;
		end;
end;
	
procedure signup;
var
nama,user,pass1,pass2:string;
i:integer;

begin
		writeln('    Signup    ');
		writeln();
        write('Name     : '); readln(nama);
        write('Username : '); readln(user);
        write('Password : '); readln(pass1);
        write('Re-enter Password : '); readln(pass2);

        i:=1;
        while (length(usr[i].usernm) <> 0) and (usr[i].usernm <> user) do
                i:=i+1;
			if (nama = '') or (user = '') or (pass1 = '') or (pass2 = '') then
				begin
					clrscr;
					writeln('All field must be fill');
					writeln('----------------------');
					readln();
					clrscr;
				end
			else
				begin
					if (usr[i].usernm = user) then
						begin
						 clrscr;
						 writeln('Username Already Exist');
						 writeln('----------------------');
						 readln();
						 clrscr;
						end

					else
						 begin
							if (pass1 <> pass2) then
								begin
								writeln('Password doesnt match');
								writeln('---------------------');
								readln();
								clrscr;
								signup;
								end
							else
								begin
								usr[i].nama := nama;
								usr[i].usernm := user;
								usr[i].pass := pass1;
								clrscr;
								writeln('Signup Success');
								writeln('--------------');
								readln();
								clrscr;
								end;
							end;
				end;
end;
	
procedure menu;
var
chs:string;
begin
	clrscr;
	while (chs <> '3') do
	begin
		writeln('  Main Menu  ');
		writeln();
		writeln('1. Login');
		writeln('2. Signup');
		writeln('3. Exit');
		writeln();
		write('   Choose : '); readln(chs);
			case chs of
				'1' : begin
					  clrscr;
					  login;
					  end;
					
				'2' : begin
					  clrscr;
					  signup;
					  end;
					
				'3' : begin
					  end;
					  
				''  : begin
						clrscr;
						writeln('Enter your Input');
						writeln('----------------');
					  end;

			else
				clrscr;
				writeln('Input Not Valid !');
				writeln('-----------------');
			
			end;
	end;
end;

begin
clrscr;
usrlg:=0;
	menu;
	readln;
end.
	
