% Grammatiken är inte prediktiv(LL(1)) då det krävs fler än endast nästa slutsymbol
% för att se vilken regel vi ska tillämpa, exempelvis
% en2ni(N);  
% en2ni(N1), ['og'], tyve2halvfems(N2), {N is N1+N2};
%
% Här ovan ser vi att vi måste veta om vi har terminalen og efter
% terminalen som matchar en2ni
%
% Lösningen klarar även 
dansk(0) --> ['nul'].
dansk(N) --> en2ni(N);
             ti2nitten(N);
             en2ni(N1), ['og'], tyve2halvfems(N2), {N is N1+N2};
             tyve2halvfems(N).


en2ni(1) --> ['en'].
en2ni(2) --> ['to'].
en2ni(3) --> ['tre'].
en2ni(4) --> ['fire'].
en2ni(5) --> ['fem'].
en2ni(6) --> ['seks'].
en2ni(7) --> ['syv'].
en2ni(8) --> ['otte'].
en2ni(9) --> ['ni'].

ti2nitten(10) --> ['ti'].
ti2nitten(11) --> ['ellve'].
ti2nitten(12) --> ['tolv'].
ti2nitten(13) --> ['tretten'].
ti2nitten(14) --> ['fjorten'].
ti2nitten(15) --> ['femten'].
ti2nitten(16) --> ['seksten'].
ti2nitten(17) --> ['sytten'].
ti2nitten(18) --> ['atten'].
ti2nitten(19) --> ['nitten'].

tyve2halvfems(20) --> ['tyve'].
tyve2halvfems(30) --> ['tredive'].
tyve2halvfems(40) --> ['fyrre'].
tyve2halvfems(50) --> ['fyrretyve'].
tyve2halvfems(N) --> ['halv'], halvmult(X), emfas(E), {N1 is X*E, N is N1-10}.
tyve2halvfems(N) --> mult(X), emfas(E), {N is X*E}.

mult(3) --> ['tres'].
mult(4) --> ['firs'].
mult(4) --> ['fjerds'].

halvmult(N) --> mult(N).
halvmult(5) --> ['fems'].

emfas(20) --> ['sindstyve'];
              [].


test :-  
    dansk(0, ['nul'], []),
    write(0),nl,
    dansk(1, ['en'], []),
    write(1),nl,
    dansk(2, ['to'], []),
    write(2),nl,
    dansk(3, ['tre'], []),
    write(3),nl,
    dansk(4, ['fire'], []),
    write(4),nl,
    dansk(5, ['fem'], []),
    write(5),nl,
    dansk(6, ['seks'], []),
    write(6),nl,
    dansk(7, ['syv'], []),
    write(7),nl,
    dansk(8, ['otte'], []),
    write(8),nl,
    dansk(9, ['ni'], []),
    write(9),nl,
    dansk(10, ['ti'], []),
    write(10),nl,
    dansk(11, ['ellve'], []),
    write(11),nl,
    dansk(12, ['tolv'], []),
    write(12),nl,
    dansk(13, ['tretten'], []),
    write(13),nl,
    dansk(14, ['fjorten'], []),
    write(14),nl,
    dansk(15, ['femten'], []),
    write(15),nl,
    dansk(16, ['seksten'], []),
    write(16),nl,
    dansk(17, ['sytten'], []),
    write(17),nl,
    dansk(18, ['atten'], []),
    write(18),nl,
    dansk(19, ['nitten'], []),
    write(19),nl,
    dansk(20, ['tyve'], []),
    write(20),nl,
    dansk(21, ['en','og','tyve'], []),
    write(21),nl,
    dansk(22, ['to','og','tyve'], []),
    write(22),nl,
    dansk(23, ['tre','og','tyve'], []),
    write(23),nl,
    dansk(24, ['fire','og','tyve'], []),
    write(24),nl,
    dansk(25, ['fem','og','tyve'], []),
    write(25),nl,
    dansk(26, ['seks','og','tyve'], []),
    write(26),nl,
    dansk(27, ['syv','og','tyve'], []),
    write(27),nl,
    dansk(28, ['otte','og','tyve'], []),
    write(28),nl,
    dansk(29, ['ni','og','tyve'], []),
    write(29),nl,
    dansk(30, ['tredive'], []),
    write(30),nl,
    dansk(31, ['en','og','tredive'], []),
    write(31),nl,
    dansk(32, ['to','og','tredive'], []),
    write(32),nl,
    dansk(33, ['tre','og','tredive'], []),
    write(33),nl,
    dansk(34, ['fire','og','tredive'], []),
    write(34),nl,
    dansk(35, ['fem','og','tredive'], []),
    write(35),nl,
    dansk(36, ['seks','og','tredive'], []),
    write(36),nl,
    dansk(37, ['syv','og','tredive'], []),
    write(37),nl,
    dansk(38, ['otte','og','tredive'], []),
    write(38),nl,
    dansk(39, ['ni','og','tredive'], []),
    write(39),nl,
    dansk(40, ['fyrre'], []),
    write(40),nl,
    dansk(41, ['en','og','fyrre'], []),
    write(41),nl,
    dansk(42, ['to','og','fyrre'], []),
    write(42),nl,
    dansk(43, ['tre','og','fyrre'], []),
    write(43),nl,
    dansk(44, ['fire','og','fyrre'], []),
    write(44),nl,
    dansk(45, ['fem','og','fyrre'], []),
    write(45),nl,
    dansk(46, ['seks','og','fyrre'], []),
    write(46),nl,
    dansk(47, ['syv','og','fyrre'], []),
    write(47),nl,
    dansk(48, ['otte','og','fyrre'], []),
    write(48),nl,
    dansk(49, ['ni','og','fyrre'], []),
    write(49),nl,
    dansk(50, ['halv','tres'], []),
    write(50),nl,
    dansk(51, ['en','og','halv','tres'], []),
    write(51),nl,
    dansk(52, ['to','og','halv','tres'], []),
    write(52),nl,
    dansk(53, ['tre','og','halv','tres'], []),
    write(53),nl,
    dansk(54, ['fire','og','halv','tres','sindstyve'], []),
    write(54),nl,
    dansk(55, ['fem','og','halv','tres'], []),
    write(55),nl,
    dansk(56, ['seks','og','halv','tres','sindstyve'], []),
    write(56),nl,
    dansk(57, ['syv','og','halv','tres'], []),
    write(57),nl,
    dansk(58, ['otte','og','halv','tres'], []),
    write(58),nl,
    dansk(59, ['ni','og','halv','tres'], []),
    write(59),nl,
    dansk(60, ['tres'], []),
    write(60),nl,
    dansk(61, ['en','og','tres'], []),
    write(61),nl,
    dansk(62, ['to','og','tres'], []),
    write(62),nl,
    dansk(63, ['tre','og','tres'], []),
    write(63),nl,
    dansk(64, ['fire','og','tres'], []),
    write(64),nl,
    dansk(65, ['fem','og','tres','sindstyve'], []),
    write(65),nl,
    dansk(66, ['seks','og','tres'], []),
    write(66),nl,
    dansk(67, ['syv','og','tres','sindstyve'], []),
    write(67),nl,
    dansk(68, ['otte','og','tres'], []),
    write(68),nl,
    dansk(69, ['ni','og','tres'], []),
    write(69),nl,
    dansk(70, ['halv','fjerds'], []),
    write(70),nl,
    dansk(71, ['en','og','halv','fjerds'], []),
    write(71),nl,
    dansk(72, ['to','og','halv','fjerds'], []),
    write(72),nl,
    dansk(73, ['tre','og','halv','fjerds'], []),
    write(73),nl,
    dansk(74, ['fire','og','halv','fjerds'], []),
    write(74),nl,
    dansk(75, ['fem','og','halv','fjerds'], []),
    write(75),nl,
    dansk(76, ['seks','og','halv','fjerds','sindstyve'], []),
    write(76),nl,
    dansk(77, ['syv','og','halv','fjerds'], []),
    write(77),nl,
    dansk(78, ['otte','og','halv','fjerds'], []),
    write(78),nl,
    dansk(79, ['ni','og','halv','fjerds'], []),
    write(79),nl,
    dansk(80, ['firs'], []),
    write(80),nl,
    dansk(81, ['en','og','firs'], []),
    write(81),nl,
    dansk(82, ['to','og','firs','sindstyve'], []),
    write(82),nl,
    dansk(83, ['tre','og','firs'], []),
    write(83),nl,
    dansk(84, ['fire','og','firs'], []),
    write(84),nl,
    dansk(85, ['fem','og','firs','sindstyve'], []),
    write(85),nl,
    dansk(86, ['seks','og','firs'], []),
    write(86),nl,
    dansk(87, ['syv','og','firs'], []),
    write(87),nl,
    dansk(88, ['otte','og','firs'], []),
    write(88),nl,
    dansk(89, ['ni','og','firs'], []),
    write(89),nl,
    dansk(90, ['halv','fems','sindstyve'], []),
    write(90),nl,
    dansk(91, ['en','og','halv','fems'], []),
    write(91),nl,
    dansk(92, ['to','og','halv','fems'], []),
    write(92),nl,
    dansk(93, ['tre','og','halv','fems'], []),
    write(93),nl,
    dansk(94, ['fire','og','halv','fems'], []),
    write(94),nl,
    dansk(95, ['fem','og','halv','fems'], []),
    write(95),nl,
    dansk(96, ['seks','og','halv','fems'], []),
    write(96),nl,
    dansk(97, ['syv','og','halv','fems','sindstyve'], []),
    write(97),nl,
    dansk(98, ['otte','og','halv','fems'], []),
    write(98),nl,
    dansk(99, ['ni','og','halv','fems'], []),
    write(99), nl.

feltest :- 
    \+ dansk(X0, ['tjugofem'], []),
    write(['tjugofem']),nl,
    \+ dansk(X1, ['noll'], []),
    write(['noll']),nl,
    \+ dansk(X2, ['null'], []),
    write(['null']),nl,
    \+ dansk(X3, ['nul','en'], []),
    write(['nul','en']),nl,
    \+ dansk(X4, ['kameloso'], []),
    write(['kameloso']),nl,
    \+ dansk(X5, ['to','sindstyve'], []),
    write(['to','sindstyve']),nl,
    \+ dansk(X6, ['tres','sindstyve','sindstyve'], []),
    write(['tres','sindstyve','sindstyve']),nl.
