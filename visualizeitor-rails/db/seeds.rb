def cria_periodo_com_descricao_materias(descricao_materias_array, periodo)
  descricao_materias = Course.create(descricao_materias_array)
  courses = []

fila = 0
  descricao_materias.each do |descricao_materia|
    materia = ProgramItem.create({course:descricao_materia, row:fila, column: periodo})
    courses.push(materia)
    fila = fila + 1
  end
  courses
end

bcc = Major.create({name: "BCC"})
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
  ], 6)

grade_nova.program_items << descricao_materias_periodo1
grade_nova.program_items << descricao_materias_periodo2
grade_nova.program_items << descricao_materias_periodo3
grade_nova.program_items << descricao_materias_periodo4
grade_nova.program_items << descricao_materias_periodo5
grade_nova.program_items << descricao_materias_periodo6
grade_nova.program_items << descricao_materias_periodo7


p1 = cria_periodo_com_descricao_materias(
[
{code:"CI055",  name:"ALGORITMOS E ESTRUTURAS DE DADOS I"},
{code:"CI063",  name:"MÁQUINAS PROGRAMÁVEIS"},
{code:"CI066",  name:"OFICINA DE PROGRAMAÇÃO"},
{code:"CM045",  name:"GEOMETRIA ANALÍTICA I"},
{code:"CM046",  name:"INTRODUÇÃO À ÁLGEBRA"},
{code:"CM201",  name:"CÁLCULO DIFERENCIAL E INTEGRAL I"}
  ], 0)

p2 = cria_periodo_com_descricao_materias(
[
{code:"CI056",  name:"ALGORITMOS E ESTRUTURAS DE DADOS II"},
{code:"CI067",  name:"OFICINA DE COMPUTAÇÃO"},
{code:"CI068",  name:"CIRCUITOS LÓGICOS"},
{code:"CM005",  name:"ÁLGEBRA LINEAR"},
{code:"CM202",  name:"CÁLCULO DIFERENCIAL E INTEGRAL II"},
{code:"CI202",  name:"MÉTODOS NUMÉRICOS"}],1)

p3 = cria_periodo_com_descricao_materias(
  [
{code:"CI057",  name:"ALGORITMOS E ESTRUTURAS DE DADOS III"},
{code:"CI064",  name:"SOFTWARE BÁSICO I"},
{code:"CI210",  name:"PROJETOS DIGITAIS E MICROPROCESSADORES"},
{code:"CI237",  name:"MATEMÁTICA DISCRETA"},
{code:"SA214",  name:"INTRODUÇÃO À TEORIA GERAL DE ADMINISTRAÇÃO"},
{code:"CE003",  name:"ESTATÍSTICA II"}],2)

p4 = cria_periodo_com_descricao_materias(
[
{code:"CI059",  name:"INTRODUÇÃO À TEORIA DA COMPUTAÇÃO"},
{code:"CI060",  name:"SEMINÁRIOS DE INFORMÁTICA I"},
{code:"CI065",  name:"ALGORITMOS E TEORIA DOS GRAFOS"},
{code:"CI069",  name:"ADMINISTRAÇÃO DE EMPRESAS DE INFORMÁTICA"},
{code:"CI212",  name:"ORGANIZAÇÃO E ARQUITETURA DE COMPUTADORES"},
{code:"CI219",  name:"ANÁLISE E PROJETO DE SISTEMAS"},
{code:"CM224",  name:"PESQUISA OPERACIONAL I"}],3)

p5 = cria_periodo_com_descricao_materias([
{code:"CI058",  name:"REDES DE COMPUTADORES I"},
{code:"CI062",  name:"TECNICAS ALTERNATIVAS DE PROGRAMAÇÃO"},
{code:"CI211",  name:"CONSTRUÇÃO DE COMPILADORES"},
{code:"CI215",  name:"SISTEMAS OPERACIONAIS"},
{code:"CI235",  name:"ESTÁGIO SUPERVISIONADO I"},
{code:"SIN070",  name:"ORIENTAÇÃO BIBLIOGRÁFICA - B"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"}], 4)

p6 = cria_periodo_com_descricao_materias([
{code:"CI061",  name:"REDES DE COMPUTADORES II"},
{code:"CI214",  name:"ESTRUTURAS DE LINGUAGENS DE PROGRAMAÇÃO"},
{code:"CI218",  name:"SISTEMAS DE BANCO DE DADOS"},
{code:"CI236",  name:"ESTÁGIO SUPERVISIONADO II"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"}], 5)

p7 = cria_periodo_com_descricao_materias([
{code:"CI220",  name:"TEORIA DE SISTEMAS"},
{code:"CI221",  name:"ENGENHARIA DE SOFTWARE"},
{code:"TGI",  name:"TRABALHO DE GRADUAÇÃO I"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"}], 6)

p8 = cria_periodo_com_descricao_materias([
{code:"TGII",  name:"TRABALHO DE GRADUAÇÃO II"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"},
{code:"OPT",  name:"DISCIPLINA OPTATIVA"}], 7)

grade_antiga.program_items << p1
grade_antiga.program_items << p2
grade_antiga.program_items << p3
grade_antiga.program_items << p4
grade_antiga.program_items << p5
grade_antiga.program_items << p6
grade_antiga.program_items << p7
grade_antiga.program_items << p8