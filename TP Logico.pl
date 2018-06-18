quienMiraQue(juan,himym).
quienMiraQue(juan,futurama).
quienMiraQue(juan,got).
quienMiraQue(nico,starWars).
quienMiraQue(maiu,starWars).
quienMiraQue(maiu,onePiece).
quienMiraQue(maiu,got).
quienMiraQue(nico,got).
quienMiraQue(gaston,hoc).

quiereVer(juan,hoc).
quiereVer(aye,got).
quiereVer(gaston,himym).

cantidadDeCapitulos(got,3,12).
cantidadDeCapitulos(got,2,10).
cantidadDeCapitulos(himym,1,23).
cantidadDeCapitulos(drHouse,8,16).

esPopular(got).
esPopular(hoc).
esPopular(starWars).

%Todo lo relacionado con Mad Med, o lo que Alf no mira series, no corresponde colocarlo en la base de conocimientos por el principio de universo cerrado.



paso(futurama, 2, 3, muerte(seymourDiera)).
paso(starWars, 10, 9, muerte(emperor)).
paso(starWars, 1, 2, relacion(parentesco, anakin, rey)).
paso(starWars, 3, 2, relacion(parentesco, vader, luke)).
paso(himym, 1, 1, relacion(amorosa, ted, robin)).
paso(himym, 4, 3, relacion(amorosa, swarley, robin)).
paso(got, 4, 5, relacion(amistad, tyrion, dragon)).

leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)). 
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).

esSpoiler(Serie,PosibleSpoiler):-
     quienMiraQue(_,Serie),
     paso(Serie,_,_,PosibleSpoiler).

% Se pueden realizar consultas existenciales e individuales ya que se trata de un predicado inversible

leSpoileo(PersonaUno,PersonaDos,Serie):-
    miraOQuiereMirar(PersonaDos,Serie),
    leDijo(PersonaUno,PersonaDos,Serie,Spolier),
	esSpoiler(Serie,Spolier),
    PersonaUno \= PersonaDos.

miraOQuiereMirar(PersonaDos,Serie):-
    quienMiraQue(PersonaDos,Serie).
miraOQuiereMirar(PersonaDos,Serie):-
    quiereVer(PersonaDos,Serie).

% Se pueden hacer consultas individuales y al mismo tiempo existenciales porque se trata de un predicado inversible

esPersona(Persona):-
    quienMiraQue(Persona,_).

esPersona(Persona):-
    quiereVer(Persona,_).

televidenteResponsable(Persona):-
    esPersona(Persona),
    not(leSpoileo(Persona,_,_)).


vieneZafando(Serie,Persona):-
    esPersona(Persona),
	miraOQuiereMirar(Persona,Serie),
    not(leSpoileo(_,Persona,Serie)),
    esPopularOEsFuerte(Serie).

esSerie(Serie):-
    miraOQuiereMirar(_,Serie).
esSerie(Serie):-
    cantidadDeCapitulos(Serie,_,_).


esPopularOEsFuerte(Serie):- esPopular(Serie).
esPopularOEsFuerte(Serie):-
    cantidadDeCapitulos(Serie,Temporada,_),
     forall(cantidadDeCapitulos(Serie,Temporada,_),esFuerte(Serie,Temporada)).

esFuerte(Serie,Temporada):- paso(Serie,Temporada,_,muerte(_)).
esFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(parentesco,_,_)).
esFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(amorosa,_,_)).

:- begin_tests(spoiler_alert).

test(esSpoiler_muerte_emperor_starWars, nondet) :- 
	esSpoiler(starWars, muerte(emperor)).
test(esSpoiler_muerte_pedro_starWars, fail) :- 
	esSpoiler(starWars, muerte(pedro)).
test(esSpoiler_relacion_anakin_rey_starWars, nondet) :- 
	esSpoiler(starWars, relacion(parentesco, anakin, rey)).
test(esSpoiler_relacion_anakin_lavezzi_starWars, fail) :- 
	esSpoiler(starWars, relacion(parentesco, anakin, lavezzi)).

test(leSpoileo_gaston_maiu_got, nondet) :- 
	leSpoileo(gaston, maiu, got).
test(leSpoileo_nico_maiu_starWars, nondet) :- 
	leSpoileo(gaston, maiu, got).
	
test(televidenteResponsable_juan, nondet) :-
	televidenteResponsable(juan).
test(televidenteResponsable_aye, nondet) :-
	televidenteResponsable(aye).
test(televidenteResponsable_maiu, nondet) :-
	televidenteResponsable(maiu).
test(televidenteResponsable_nico, fail) :-
	televidenteResponsable(nico).
test(televidenteResponsable_gaston, fail) :-
	televidenteResponsable(gaston).	
test(televidenteResponsable_inversible, set(UnaPersona == [aye, maiu, juan])) :-
	televidenteResponsable(UnaPersona).	

test(vieneZafando_maiu_ninguna, fail) :-
	vieneZafando(_,maiu).
test(vieneZafando_juan_himym, nondet) :-
	vieneZafando(himym,juan).
test(vieneZafando_juan_got, nondet) :-
	vieneZafando(got,juan).	
test(vieneZafando_juan_hoc, nondet) :-
	vieneZafando(hoc,juan).
test(vieneZafando_nico_starWars, set(UnaPersona == [nico])) :-
	vieneZafando(starWars,UnaPersona).	

:- end_tests(spoiler_alert).