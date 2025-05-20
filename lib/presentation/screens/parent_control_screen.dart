import 'package:edutainment_app/core/theme/colors_data.dart';
import 'package:edutainment_app/domain/provider/user_data.dart';
import 'package:edutainment_app/presentation/screens/each_child_control_screen.dart';
import 'package:edutainment_app/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class ParentControlScreen extends StatefulWidget {
  static final routeName = 'parent_control_screen';

  @override
  State<ParentControlScreen> createState() => _ParentControlScreenState();
}

class _ParentControlScreenState extends State<ParentControlScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmController = TextEditingController();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserData>(context,listen: false).getStudent();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserData>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Add your child',style: TextStyle(fontSize: 15,color: AppColors.primary),),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white10
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: nameController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: passwordController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: confirmController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              hintStyle: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                        width: 20,
                        child: ElevatedButton(onPressed: () async {
                          if(passwordController.text==confirmController.text){
                            if(emailController.text.isEmpty && nameController.text.isEmpty && passwordController.text.isEmpty){
                              final success = await userDataProvider.addStudent(name: nameController.text,email: emailController.text,password: passwordController.text);
                              if(success){
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  title: Text('Successed'),
                                   content: Text('Successfully added your child '),
                                  actions: [
                                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                                  ],
                                ),);
                              }
                              else{
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  title: Text('Field'),
                                  content: Text('Field to add your child'),
                                  actions: [
                                    TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                                  ],
                                ),);

                              }
                            }
                            else{
                              showDialog(context: context, builder: (context) => AlertDialog(
                                title: Text('Failed to Submit'),
                                content: Text('Please fill all required filed'),
                                actions: [
                                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                                ],
                              ),);
                            }
                          }
                          else{
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: Text('Password mismatched'),
                              content: Text('Please check password you entered'),
                              actions: [
                                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))
                              ],
                            ),);
                          }
                          userDataProvider.getStudent();
                        }, child: Text('Submit',style: TextStyle(color: AppColors.lightBackground),))
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Divider(),
            Column(
              children: [
                Text('Your Children',style: TextStyle(color: AppColors.primary,fontSize: 15),),
                Consumer<UserData>(
                  builder: (context,userData,child){
                    return userData.myChildList.isEmpty?Container(
                        child: Text('You does not have a child')):
                    Container(
                      height: 300,
                      padding: EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: userData.myChildList.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: (){
                            print('taped');
                            EachChildControlScreen(childData: userData.myChildList[index],).launch(context);
                          },
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            userData.myChildList[index].name,
                            style: TextStyle(color: AppColors.primary),
                          ),
                          trailing: IconButton(onPressed: (){
                            showDialog(context: context, builder: (context) => AlertDialog(
                              title: Text('Warning',style: TextStyle(fontSize: 14,color: Colors.red),),
                              content: Text('Are you sure want to remove ${userData.myChildList[index].name}'),
                              actions: [
                                TextButton(onPressed: () async{
                                 final success = await userData.removeStudent(userData.myChildList[index].email);
                                 if(success){
                                   showDialog(context: context, builder: (context) => AlertDialog(
                                     title: Text('Success',style: TextStyle(color: AppColors.primary,fontSize: 14),),
                                     content: Text('Successfully removed'),
                                   ),);
                                 }
                                 else{
                                   showDialog(context: context, builder: (context) => AlertDialog(
                                     title: Text('Field to remove'),
                                     content: Text('Field to remove, please try again'),
                                   ),);
                                 }
                                }, child: Text('Ok')),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('Cancel',style: TextStyle(color: Colors.red),)),
                              ],
                            ),);
                          }, icon: Icon(Icons.delete,color: Colors.red,)),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
