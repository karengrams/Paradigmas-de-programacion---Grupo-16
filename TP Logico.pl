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

leSpoileo(PersonaUno,PersonaDos,Spoiler):-
    miraOQuiereMirar(PersonaDos,Serie),
    leDijo(PersonaUno,PersonaDos,Serie,Spoiler),
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
    not(leSpoileo(Persona,_,_)),
    esPopularOEsFuerte(Serie).

esSerie(Serie):-
    miraOQuiereMirar(_,Serie).
esSerie(Serie):-
    cantidadDeCapitulos(Serie,_,_).


esPopularOEsFuerte(Serie):- esPopular(Serie).
esPopularOEsFuerte(Serie):-
    esSerie(Serie),
     forall(cantidadDeCapitulos(Serie,Temporada,_),esFuerte(Serie,Temporada)).

esFuerte(Serie,Temporada):- paso(Serie,Temporada,_,muerte(_)).
esFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(parentesco,_,_)).
esFuerte(Serie,Temporada):- paso(Serie,Temporada,_,relacion(amorosa,_,_)).