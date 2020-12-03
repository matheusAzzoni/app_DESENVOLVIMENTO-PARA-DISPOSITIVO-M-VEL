import 'package:flutter/material.dart';

class Contato {
  String _nome;
  int _telefone;
  Contato(this._telefone, [this._nome]) {}
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Contato> lista = []; // Lista vazia

  // Construtor
  MyApp() {
    Contato contato1 = Contato(56114033625, "Matheus");
    Contato contato2 = Contato(89812983407, "Bill");
    lista.add(contato1);
    lista.add(contato2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Contato> lista;

  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Contato> lista;

  _HomePageState(this.lista);

  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Contatos"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._nome}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final List lista;
  final double _fontSize = 17.0;

  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.lightGreen[300]),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Informações dos contatos",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesDoContato(lista),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1_sharp),
            title: Text(
              "Cadastrar um Novo Contato",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarContato(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.face),
              title: Text(
                "Sobre",
                style: TextStyle(fontSize: _fontSize),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sobre(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TelaInformacoesDoContato extends StatefulWidget {
  final List<Contato> lista;

  TelaInformacoesDoContato(this.lista);

  @override
  _TelaInformacoesDoContato createState() => _TelaInformacoesDoContato(lista);
}

class _TelaInformacoesDoContato extends State<TelaInformacoesDoContato> {
  final List lista;
  Contato contato;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  bool _edicaoHabilitada = false;

  _TelaInformacoesDoContato(this.lista) {
    if (lista.length > 0) {
      index = 0;
      contato = lista[0];
      nomeController.text = contato._nome;
      telefoneController.text = contato._telefone.toString();
    }
  }

  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      contato = lista[index];
      nomeController.text = contato._nome;
      telefoneController.text = contato._telefone.toString();
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index]._peso = double.parse(telefoneController.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do contato";
    if (contato == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum contato encontrado!"),
            Container(
              color: Colors.blueGrey,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Primeiro',
                child: Text("Hab. Edição"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome completo",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Telefone",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: telefoneController,
              ),
            ),
            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaCadastrarContato extends StatefulWidget {
  final List<Contato> lista;

  TelaCadastrarContato(this.lista);

  @override
  _TelaCadastrarContatoState createState() => _TelaCadastrarContatoState(lista);
}

class _TelaCadastrarContatoState extends State<TelaCadastrarContato> {
  final List<Contato> lista;
  String _nome = "";
  int _telefone = 0;
  double _fontSize = 20.0;
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();

  _TelaCadastrarContatoState(this.lista);

  void _cadastrarPaciente() {
    _nome = nomeController.text;
    _telefone = int.parse(telefoneController.text);
    if (_telefone > 0 && _nome != "") {
      var contato = Contato(_telefone, _nome);
      lista.add(contato);
      nomeController.text = "";
      telefoneController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Contato"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Dados do Contato:",
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome completo",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Telefone",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: telefoneController,
              ),
            ),
            RaisedButton(
              child: Text(
                "Cadastrar contato",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _cadastrarPaciente,
            ),
          ],
        ),
      ),
    );
  }
}

class Sobre extends StatefulWidget {
  SobreContext createState() => SobreContext();
}

class SobreContext extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    var titulo = "Sobre";

    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Column(
        children: <Widget>[
          Text(
            "Matheus dos Santos Azzoni RA 190008930",
            style: TextStyle(fontSize: 20.0),
          ),
          Container(height: 20, width: 20),
          Text(
            "Programa para cadastrar contastos de telefone",
            style: TextStyle(fontSize: 20.0),
          ),
          Container(height: 20, width: 20),
        ],
      ),
    );
  }
}
