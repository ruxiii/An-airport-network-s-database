-----------cereri sql + limbal natural

/*Sa se selecteze id-ul biletelor si numele pasagerilor, cu majuscule si
ordonati alfabetic, ale caror bagaje ajung pe aeroportul 
unde opereaza compania aeriana 'Klm */

select upper(p.nume_pasager) as Nume, bil.id_bilet
from pasageri p, bagaje b, bilete bil, companii_aeriene c
where b.id_aeroport=c.id_aeroport and b.id_pasager=p.id_pasager and 
    initcap(c.nume_companie)='Klm' and bil.id_pasager=p.id_pasager and 
    c.id_aeroport=p.id_aeroport
order by p.nume_pasager asc;



/*Sa se realizeze un bloc de cerere denumit "situatie" in care se vor selecta numele pasagerului, id-ul, pretul
si operatorul biletului pentru care pretul sau este mai mare decat pretul mediu al tuturor biletelor ai caror 
operatori sunt companiile al caror sediu se afla in orasul in care id-ul aeroportului pe care ajung bagajele este 1100. 
Pasagerilor care indeplinesc aceasta conditie si au zborul operat de 'KLM' li se va aplica o reducere de 10%, noua coloana
fiind denumita NOUL_PRET*/

with situatie as(
select p.nume_pasager, bil.id_bilet, bil.pret, bil.operator_bilet
from bilete bil , pasageri p 
where bil.id_pasager= p.id_pasager and bil.pret>(select round(avg(pret))
                                                from bilete
                                                where operator_bilet=( select nume_companie
                                                                        from companii_aeriene 
                                                                        where oras_sediu in ( select destinatie_finala_bagaj
                                                                                        from bagaje
                                                                                        where id_aeroport=1100
                                                                        )
                                                                )
                                                )
            )
select nume_pasager, pret as VECHIUL_PRET, decode(operator_bilet, 'KLM', pret-pret*0.1, pret) as NOUL_PRET
from situatie;



/*Sa se selecteze numele angajatului, salariul sau vechi cu numele de VECHIUL_SALARIU si noul lor salariu
ca NOUL_SALARIU, stiind ca cei care au salariul mai mic de 700 vor primi o marire de 20%. Acest lucru se aplica
numai anagajatilor care lucreaza de mai mult de 3000 de zile in departamentele lor, iar ultima zi a lunii in 
care au fost angajati este 31.03.2010. Sa se ordoneze alfabetic rezultatele obtinute  */

select nume_angajat, salariu_angajati as VECHIUL_SALARIU,
case 
when salariu_angajati <7000 then
    salariu_angajati+salariu_angajati*0.2
else salariu_angajati
end
as NOUL_SALARIU
from angajati
where round(sysdate-to_date(data_angajarii))>3000 and last_day(data_angajarii)='31-03-2010'
order by nume_angajat asc;



/*Sa se selecteze id-ul, operatorul si pretul unui bilet, astfel: daca acesta 
nu are pret se va afisa 0, altfel pretul biletului*/

select id_bilet, operator_bilet, nvl(pret, 0) as Pret
from bilete;



/*Sa se se selecteze nationalitatea care contine 'ana' si numarul de pasageri cu acea nationalitate
pentru pasagerii care tranziteaza aeroporturile ale caror turnuri de control
au id-rile 900, respectiv 910. Ulterior, se va selecta numarul maxim de pasageri din rezultatele obtinute*/

select * from pasageri;

select max(numar)as Maxim
from(
        select nationalitate, count(*) as numar
        from pasageri p
        where p.id_aeroport in (
                                    select a.id_aeroport
                                    from aeroport a
                                    where p.id_aeroport=a.id_aeroport and 
                                    a.id_aeroport in ( 
                                                        select t.id_aeroport
                                                        from turn_control t
                                                        where t.id_aeroport=a.id_aeroport
                                                        and t.id_turn_control=910 
                                                        or t.id_turn_control=900
                                                      )
                                )
        group by nationalitate
        having nationalitate like '%ana%'
);





-----------suprimare&stergere

/*Sa se stearga biletele de la operatorul care opereaza pe aeroportul cu id-ul 1200.*/

delete from bilete
where operator_bilet in (   select nume_companie 
                            from companii_aeriene
                            where id_aeroport=1200
                        );
                        

/*Sa se modifice salariul angajatilor din tabela de angajati care au salariul mai mare de 5000 cu media salariilor din tabela de personal.*/

update angajati
set salariu_angajati=(  select round(avg(salariu_personal))
                        from personal)
where salariu_angajati > 5000; 
                        
                        
/*Sa se stearga bagajele paserilor care contin ‘a’ in nume.*/

delete from bagaje 
where id_pasager in (   select id_pasager 
                        from pasageri
                        where nume_pasager like '%a%'
                    );
