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
