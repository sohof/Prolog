link(p0, p1 ,5).
link(p0, p2 ,2).
link(p0, p5 ,3).
link(p1, p2 ,2).
link(p1, p3 ,3).
link(p2, p1 ,2).
link(p2, p3 ,5).
link(p3, p4 ,1).
link(p4, p5 ,1).
link(p5, p4 ,1). 

/* Vi delar upp problemet i att först hitta en acyklisk path från någon nod X till End.
Så fort vi har hittat en sådan nod har vi en väg från X till End, dessa noder lägger i
vår Path1. Sedan blir X:et vår nya s.k End. Och vi söker en ny mellan nod som inte finns
i vår redan besökta path1. Längs grenerna adderas vi vikterna. När sökningen efter ny
mellan nod sammanfaller med vår Start Nod ja då är vi klara. Så path byggs upp bakifrån
från slutnoden till startnoden. */

path(Start,End,Distance,Path):-
	path1(Start,[End],Distance, 0,Path).

path1(Start,[Start|Path1], Acc, Acc,[Start|Path1]).

path1(Start,[End|Path1],Distance, Old_Acc,Path):-
	link(X, End, Curr_Acc),
	\+ member(X,Path1),
	New_Acc is Old_Acc + Curr_Acc,
	path1(Start,[X,End|Path1], Distance, New_Acc, Path).


int(1).
int(N):- int(N1), N is N1+1.

/*Vi använder iterativ fördjupning för att hitta den kortaste vägen. Så först kolla vi om har en path med längd 1. Om vi inte har det så
kollar vi om vi har en med längd 2 osv. För varje längd som vi generarar och testar kommer path predikatet att generara alla paths för att kolla om
det finns någon given path med exakt angiven längd. Vilket egentligen är en ganska onödig dåligt tillvägagångsätt för att hitta pathen
med det kortaste avståndet. */
path_iteration(Start,End,Distance,Path):-
	path(Start,End,_Distance,_Path),
	int(Distance),
	path(Start,End,Distance,Path).


% Nedan är extra version som är tänkt att vara bättre/snabbare lösning än iterativ fördjupning.
% Så tar gärna emot feedback om den och ifall jag kunde gjort på smartare/bättre sätt.
	
/*Vid första anrop kör vi findall för att få alla paths och sparar den som en lista Solutions
av tupler (Dist,Path). Sedan anropar vi en annan version av minPath och skickar med 
vår lista av Paths, samt initierar två hjälpvariabler TempMinPath och TempMinDist*/
minPath(Start, End, MinDist, MinPath):-
	findall((Dist,Path),path(Start,End,Dist,Path),Solutions),
	minPath(Solutions,50,[],MinDist,MinPath),!.

/* Basfall Har vi kommit så den minsta Path/distan sparad i tempvariablerna och vi bara uniferar dem
med vår lösningsparametrar */
minPath([], TempMinDist, TempMinPath, TempMinDist,TempMinPath).

/*Vi kollar om den aktuella headen är en kortare path än det som finns i våra tempvariabler.
Om den är det så skickar in dem i den rekursiva anropet. Och ifall aktuell lösning inte var bättre
Så ska versionen nedan användas, där vi behåller den tillfälligt bästa lösningen. */

minPath([(Dist,Path)|Solutions], TempMinDist,TempMinPath,MinDist,MinPath):-
	Dist=<TempMinDist,
	minPath(Solutions,Dist,Path,MinDist,MinPath).

minPath([(Dist,Path)|Solutions],TempMinDist,TempMinPath,MinDist,MinPath):-
	Dist>TempMinDist,
	minPath(Solutions,TempMinDist,TempMinPath,MinDist,MinPath).