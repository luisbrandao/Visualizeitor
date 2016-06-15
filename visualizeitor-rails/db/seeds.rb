def cria_periodo_com_descricao_materias(descricao_materias_array, periodo)
  descricao_materias = []

  descricao_materias_array.each do |desc_materia|
    curso = Course.find_by_code(desc_materia[:code])
    if (curso.nil?)
      curso = Course.create(desc_materia)
    end
    descricao_materias.push(curso)
  end

  courses = []

fila = 0
  descricao_materias.each do |descricao_materia|
    materia = ProgramItem.create({course:descricao_materia, row:fila, column: periodo})
    courses.push(materia)
    fila = fila + 1
  end
  courses
end

bcc = Major.create({name: "BCC", code: "21A"})
grade_nova = Program.create({name: "Grade Nova", code: "1227"})
grade_antiga = Program.create({name: "Grade Antiga", code: "308"})
bcc.programs << grade_nova
bcc.programs << grade_antiga

descricao_materias_periodo1 = cria_periodo_com_descricao_materias(
[
  {code:"CI068", name:"Circuitos Lógicos"},
  {code:"CI055", name:"Algoritmos e Estrutura de Dados I"},
  {code:"CM046", name:"Introdução a Álbebra"},
  {code:"CM045", name:"Geometria Analítica I"},
  {code:"CM201", name:"Cálculo Diferencial e Integral I"}
  ], 0)

descricao_materias_periodo2 = cria_periodo_com_descricao_materias(
[
  {code:"CI210", name:"Projetos Digitais e Microprocessadores"},
  {code:"CI056", name:"Algoritmos e Estruturas de Dados II"},
  {code:"CI067", name:"Oficina de Computação"},
  {code:"CM005", name:"Álbebra Linear"},
  {code:"CM202", name:"Cálculo Diferencial e Integral II"}
  ], 1)

descricao_materias_periodo3 = cria_periodo_com_descricao_materias(
[
  {code:"CI212", name:"Organização e Arquitetura de Computadores"},
  {code:"CI057", name:"Algoritmos e Estruturas de Dados III"},
  {code:"CI064", name:"Software Básico"},
  {code:"CI237", name:"Matemática Discreta"},
  {code:"CI166", name:"Metodologia Científica"}
  ], 2)

descricao_materias_periodo4 = cria_periodo_com_descricao_materias(
[
  {code:"CI215", name:"Sistemas Operacionais"},
  {code:"CI062", name:"Técnicas Alternativas de Programação"},
  {code:"CE003", name:"Estatística II"},
  {code:"CI058", name:"Redes de Computadores I"},
  {code:"CI164", name:"Introdução à Computação Científica"}
  ], 3)
descricao_materias_periodo5 = cria_periodo_com_descricao_materias(
[
  {code:"CI162", name:"Engenharia de Requisitos"},
  {code:"CI065", name:"Algoritmos e Teoria dos Grafos"},
  {code:"CI059", name:"Introdução à Teoria da Computação"},
  {code:"CI061", name:"Redes de Computadores II"},
  {code:"SA214", name:"Introdução a Teoria Geral da Administração"}
  ], 4)

descricao_materias_periodo6 = cria_periodo_com_descricao_materias(
[
  {code:"CI163", name:"Projeto de Software"},
  {code:"CI165", name:"Análise de Algoritmos"},
  {code:"CI209", name:"Inteligência Artificial"},
  {code:"CI218", name:"Sistemas de Bancos de Dados"},
  {code:"CI220", name:"Teoria de Sistemas"}
  ], 5)

descricao_materias_periodo7 = cria_periodo_com_descricao_materias(
[
  {code:"CI221", name:"Engenharia de Software"},
  {code:"CI211", name:"Construção de Compiladores"},
  {code:"TGI",  name:"Trabalho de Graduação I"},
  {code:"OPT",  name:"Disciplina Optativa"},
  {code:"OPT",  name:"Disciplina Optativa"}], 6)

descricao_materias_periodo8 = cria_periodo_com_descricao_materias(
[
  {code:"OPT",  name:"Disciplina Optativa"},
  {code:"OPT",  name:"Disciplina Optativa"},
  {code:"TGII", name:"Trabalho de Graduação II"},
  {code:"OPT",  name:"Disciplina Optativa"},
  {code:"OPT",  name:"Disciplina Optativa"}], 7)

grade_nova.program_items << descricao_materias_periodo1
grade_nova.program_items << descricao_materias_periodo2
grade_nova.program_items << descricao_materias_periodo3
grade_nova.program_items << descricao_materias_periodo4
grade_nova.program_items << descricao_materias_periodo5
grade_nova.program_items << descricao_materias_periodo6
grade_nova.program_items << descricao_materias_periodo7
grade_nova.program_items << descricao_materias_periodo8


p1 = cria_periodo_com_descricao_materias(
[
{code:"CI055",  name:"Algoritmos e Estruturas de Dados I"},
{code:"CI063",  name:"Máquinas Programáveis"},
{code:"CI066",  name:"Oficina de Programação"},
{code:"CM045",  name:"Geometria Analítica I"},
{code:"CM046",  name:"Introdução à Álgebra"},
{code:"CM201",  name:"Cálculo Diferencial e Integral I"}
  ], 0)

p2 = cria_periodo_com_descricao_materias(
[
{code:"CI056",  name:"Algoritmos e Estruturas de Dados II"},
{code:"CI067",  name:"Oficina de Computação"},
{code:"CI068",  name:"Circuitos Lógicos"},
{code:"CM005",  name:"Álgebra Linear"},
{code:"CM202",  name:"Cálculo Diferencial e Integral II"},
{code:"CI202",  name:"Métodos Numéricos"}],1)

p3 = cria_periodo_com_descricao_materias(
  [
{code:"CI057",  name:"Algoritmos e Estruturas de Dados III"},
{code:"CI064",  name:"Software Básico I"},
{code:"CI210",  name:"Projetos Digitais e Microprocessadores"},
{code:"CI237",  name:"Matemática Discreta"},
{code:"SA214",  name:"Introdução à Teoria Geral De Administração"},
{code:"CE003",  name:"Estatística II"}],2)

p4 = cria_periodo_com_descricao_materias(
[
{code:"CI059",  name:"Introdução à Teoria Da Computação"},
{code:"CI060",  name:"Seminários De Informática I"},
{code:"CI065",  name:"Algoritmos e Teoria dos Grafos"},
{code:"CI069",  name:"Administração de Empresas de Informática"},
{code:"CI212",  name:"Organização e Arquitetura de Computadores"},
{code:"CI219",  name:"Análise E Projeto De Sistemas"},
{code:"CM224",  name:"Pesquisa Operacional I"}],3)

p5 = cria_periodo_com_descricao_materias([
{code:"CI058",  name:"Redes de Computadores I"},
{code:"CI062",  name:"Tecnicas Alternativas De Programação"},
{code:"CI211",  name:"Construção de Compiladores"},
{code:"CI215",  name:"Sistemas Operacionais"},
{code:"CI235",  name:"Estágio Supervisionado I"},
{code:"SIN070",  name:"Orientação Bibliográfica - B"},
{code:"OPT",  name:"Disciplina Optativa"}], 4)

p6 = cria_periodo_com_descricao_materias([
{code:"CI061",  name:"Redes de Computadores II"},
{code:"CI214",  name:"Estruturas de Linguagens de Programação"},
{code:"CI218",  name:"Sistemas de Banco de Dados"},
{code:"CI236",  name:"Estágio Supervisionado II"},
{code:"OPT",  name:"Disciplina Optativa"},
{code:"OPT",  name:"Disciplina Optativa"}], 5)

p7 = cria_periodo_com_descricao_materias([
{code:"CI220",  name:"Teoria de Sistemas"},
{code:"CI221",  name:"Engenharia de Software"},
{code:"TGI",  name:"Trabalho de Graduação I"},
{code:"OPT",  name:"Disciplina Optativa"},
{code:"OPT",  name:"Disciplina Optativa"}], 6)

p8 = cria_periodo_com_descricao_materias([
{code:"TGII",  name:"Trabalho de Graduação II"},
{code:"OPT",  name:"Disciplina Optativa"},
{code:"OPT",  name:"Disciplina Optativa"},
{code:"OPT",  name:"Disciplina Optativa"},
{code:"OPT",  name:"Disciplina Optativa"}], 7)

grade_antiga.program_items << p1
grade_antiga.program_items << p2
grade_antiga.program_items << p3
grade_antiga.program_items << p4
grade_antiga.program_items << p5
grade_antiga.program_items << p6
grade_antiga.program_items << p7
grade_antiga.program_items << p8

Teacher.create! ([
{name:"Andre Guedes", login: "andre", access: "0", email:"andre@inf.ufpr.br", password: "123456"},
{name:"Andre Vignatti", login: "vignatti", access: "2", email:"vignatti@inf.ufpr.br", password: "123456"},
{name:"Bruno Muller", login: "bmuller", access: "1", email:"bmuller@inf.ufpr.br", password: "123456"},
{name:"Setembrino S. Ferreira Jr.", login: "setembro", access: "1", email:"setembro@inf.ufpr.br", password: "123456"},
{name:"Andrey Ricardo Pimentel", login: "andrey", access: "1", email:"andrey@inf.ufpr.br", password: "123456"},
{name:"Eduardo Todt", login: "todt", access: "2", email:"todt@inf.ufpr.br", password: "123456"},
{name:"Laura Sanchez Garcia", login: "laura", access: "0", email:"laura@inf.ufpr.br", password: "123456"},
{name:"Elias P. Duarte Jr.", login: "elias", access: "0", email:"elias@inf.ufpr.br", password: "123456"},
{name:"Leticia Leoni", login: "leticia", access: "0", email:"leticia@inf.ufpr.br", password: "123456"}
])

Category.create! ([
{descr:"Participação em iniciação científica", softlimit: "180", hardlimit: "360"},
{descr:"Participação no PET", softlimit: "180", hardlimit: "360"},
{descr:"Participação em atividades oficiais de extensão universitária de acordo com plano de trabalho reconhecido na Universidade comprovante fornecido pelo coordenador do projeto", softlimit: "180", hardlimit: "360"},
{descr:"Atividades de bolsista institucional", softlimit: "360", hardlimit: "360"},
{descr:"Atividades de monitoria", softlimit: "360", hardlimit: "360"},
{descr:"Estágios", softlimit: "180", hardlimit: "360"},
{descr:"Disciplinas eletivas", softlimit: "360", hardlimit: "360"},
{descr:"Disciplinas isoladas", softlimit: "180", hardlimit: "180"},
{descr:"Intercâmbios em outras IFES ou no exterior", softlimit: "360", hardlimit: "360"},
{descr:"Participação em empresa júnior", softlimit: "120", hardlimit: "240"},
{descr:"Atividades de tutoria em Educação à distância", softlimit: "120", hardlimit: "120"},
{descr:"Participação em evento (seminário, jornada, encontro, fórum, congresso, palestra técnica ou científica)", softlimit: "120", hardlimit: "120"},
{descr:"Participação em órgãos de representação estudantil (CEI, DEC, ENEC, UNE)", softlimit: "60", hardlimit: "120"},
{descr:"Representação estudantil em órgãos colegiados", softlimit: "15", hardlimit: "180"},
{descr:"Organização de eventos técnico-científicos", softlimit: "30", hardlimit: "60"}
])

Company.create! ([
{name:"Soluções SA.", cnpj:"78.425.986/0036-15", activity: "Desenvolvcimento web"},
{name:"Gold Doze Systems", cnpj:"03.474.482/0001-00", activity: "Desenvolvcimento web"},
{name:"Ironheart Services", cnpj:"81.815.303/0001-64", activity: "Infra-estrutura"},
{name:"Trifid", cnpj:"28.598.758/0001-92", activity: "Componentes quimicos"}
])

Contact.create! ([
{name:"Carleen Caruso", email:"email@email.com", qualification:"Engenharia da computação", phone:"(27) 7823-4498", company_id:"1"},
{name:"Devona Colburn", email:"email@email.com", qualification:"Engenharia química", phone:"(11) 2840-9118", company_id:"1"},
{name:"Burl Knudsen", email:"email@email.com", qualification:"Administração", phone:"(11) 3234-5270", company_id:"1"},
{name:"Tim Marsh ", email:"email@email.com", qualification:"Advocacia", phone:"(48) 2124-8867", company_id:"2"},
{name:"Armand Swyers", email:"email@email.com", qualification:"Ciencia da computacao", phone:"(21) 8005-9041", company_id:"2"},
{name:"Elbert Nellis", email:"email@email.com", qualification:"Adminstração", phone:"(11) 8192-5258", company_id:"3"},
{name:"Jamey Lehmkuhl", email:"email@email.com", qualification:"Design", phone:"(31) 7644-2434", company_id:"4"},
{name:"Amos Hawkins", email:"email@email.com", qualification:"Engenharia Civil", phone:"(81) 9479-6072", company_id:"4"}
])
