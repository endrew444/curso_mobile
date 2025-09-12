import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  //atributos
  final _db = FirebaseFirestore
      .instance; //controlador do FireStore(envia as tarefas para o BD)
  final User? _user = FirebaseAuth.instance.currentUser; //pega o usuário logado
  final _tarefasField = TextEditingController(); //pegar o título da tarefa

  // métodos

  //adicionar Tarefa
  void _addTarefa() async {
    if (_tarefasField.text.trim().isEmpty)
      return; //se o campo estiver vazio, não faz nada
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .add({
            "titulo": _tarefasField.text.trim(),
            "concluida": false,
            "dataCriacao": Timestamp.now(), //data e hora atual
          });
          _tarefasField.clear(); //limpa o campo após adicionar a tarefa
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao adicionar Tarefa $e")));
    }
  }

  //atualizar tarefa
  void _atualizarTarefa(String id, bool novaSituacao) async {
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .doc(id)
          .update({"concluida": novaSituacao});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao atualizar tarefa: $e")),
      );
    }
  }

  //deletar tarefa
  void _deletarTarefa(String id) async {
    try {
      await _db
          .collection("usuarios")
          .doc(_user!.uid)
          .collection("tarefas")
          .doc(id)
          .delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao deletar tarefa: $e")),
      );
    }
  }

  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      //body das tarefas
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _tarefasField,
            decoration: InputDecoration(
              labelText: "Nova Tarefa",
              border: OutlineInputBorder(),
              suffix: IconButton(
                onPressed: _addTarefa, 
                icon: Icon(Icons.add))
            ),
          ),
          SizedBox(height: 20,),
          //construir a lista de tarefas StreamBuilder
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _db.collection("usuarios")
                          .doc(_user?.uid)
                          .collection("tarefas")
                          .orderBy("dataCriacao", descending: true).snapshots(), //le a modificação da lista de tarefas
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                  return Center(child: Text("Nenhuma Tarefa Encontrada"),);
                }
                final tarefas = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (context, index){
                    final tarefa = tarefas[index];
                    //converte texto/json em Map<String,dynamic>
                    final tarefaMap = tarefa.data() as Map<String,dynamic>;
                    //ajustar a boolean 
                    bool concluida = tarefaMap["concluida"] ?? false;
                    return  ListTile( //pra kd item da lista add um listetile 
                   title: Text(tarefaMap["titulo"]),
                      leading: Checkbox(
                        value: concluida, 
                        onChanged: (value){
                          if (value != null) {
                            _atualizarTarefa(tarefa.id, value);
                          }
                        }),
                      trailing: IconButton(
                        onPressed: ()=> _deletarTarefa(tarefa.id),
                        icon: Icon(Icons.delete,color: Colors.red,)),
                    );
                  });
              }))
        ],
      ),
      ),
    );
  }
}
