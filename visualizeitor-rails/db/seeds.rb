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
grade_nova = Program.create({name: "Grade Nova"})
bcc.programs << grade_nova

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
