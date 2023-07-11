---
layout: post
title: "Making new table on an exist database - Android"
date: 2014-07-18 21:55:37 +0700
categories: Android
tag: Android, Java, SQLite
---
When working on my assignment in course named Mobile Application. I had a
problem that my program has two tables, both of them belong to a single
database.

In my program, I used SQLiteHelper, the program has two diffirential classes
which handle database working process.

***1. GroupDaoImpl***
{% highlight java linenos %}
public class TaskGroupImpl extends SQLiteOpenHelper implements TaskGroupDao{
    private static TaskGroupImpl instance = null;
    private Context context;
    private ArrayList<TaskGroup> groups;
    //DATABASE information
    private static final int DB_VERSION = 1;
    private static final String DB_NAME = "TaskManager";
    private static final String TABLE_NAME = "task_group";

    //TABLE information
    private static final String GROUP_ID = "ID";
    private static final String GROUP_NAME = "NAME";


    private TaskGroupImpl(Context context){
       super(context, DB_NAME, null, DB_VERSION);
       this.context = context;
    }
    public static TaskGroupImpl getInstance(Context context){
        Log.v("TaskGroupImpl: ", "getInstance() active");
        if (instance == null){
            instance = new TaskGroupImpl(context);
            instance.groups = new ArrayList<TaskGroup>();
        }
        return instance;
    }
    public ArrayList<TaskGroup> getAllGroups(){
        return groups;
    }
    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        String create_db = "CREATE TABLE " + TABLE_NAME+ "("
                + GROUP_ID + " INTEGER PRIMARY KEY, "
                + GROUP_NAME + " TEXT"  + ")";
        sqLiteDatabase.execSQL(create_db);
        Log.v("TaskGroup: ", "Did make TaskGroup table");
    }
    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i2) {
        sqLiteDatabase.execSQL("DROP TABLE IF EXIST " + TABLE_NAME);
        onCreate(sqLiteDatabase);
    }

    @Override
    public void onDowngrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        //super.onDowngrade(db, oldVersion, newVersion);
    }

    @Override
    public int createGroup(TaskGroup taskGroup) {
        try {
            int maxID;
            if(groups.isEmpty() == true){
                maxID = 0;
                taskGroup.setID(maxID);
            } else {
                maxID = groups.get(groups.size() - 1).getID() + 1;
                taskGroup.setID(maxID);
            }
            groups.add(taskGroup);
            SQLiteDatabase db = this.getWritableDatabase();
            ContentValues values= new ContentValues();
            values.put(GROUP_ID,taskGroup.getID());
            values.put(GROUP_NAME, taskGroup.getName());
            db.insert(TABLE_NAME, null, values);
            db.close();
            return 1;
        } catch (Exception ex){
            Log.v("TaskGroupImpl: ", "cannot create new group" );
            return 0;
        }
    }
    @Override
    public TaskGroup getTaskGroupById(int id) {
        for(int i = 0; i < groups.size(); i++){
            if (groups.get(id).getID() == id){
                return groups.get(id);
            }
        }
        return null;
    }
    @Override
    public int updateTaskGroup(TaskGroup taskGroup) {
        return 0;
    }
    @Override
    public int deleteTaskGroup(TaskGroup taskGroup) {
        try{

            SQLiteDatabase db = this.getWritableDatabase();
            db.delete(TABLE_NAME, GROUP_ID + " = ?", new String[] {String.valueOf(taskGroup.getID())});
            groups.remove(taskGroup);
            return 1;
        }
       catch (Exception ex){
           return 0;
       }
    }
    public void init(){
        groups.removeAll(groups);
        String query = "SELECT * FROM " + TABLE_NAME;
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor cursor  = db.rawQuery(query, null);

        if (cursor.moveToFirst()){
            do{
                TaskGroup group = new TaskGroup();
                group.setID(Integer.parseInt(cursor.getString(0)));
                group.setName(cursor.getString(1));
                groups.add(group);
            } while (cursor.moveToNext());
        }
    }
}
{% endhighlight %}


***2. TaskDaoImpl***

{% highlight java linenos %}
public class TaskDaoImpl extends SQLiteOpenHelper implements TaskDao  {
    //singleton
    private static TaskDaoImpl instance = null;
    private Context context;

    private ArrayList<Task> tasks;
    private static final int DATABASE_VERSION = 1;
    private static final  String DATABASE_NAME = "TaskManager";
    private static final String TABLE_TASK = "task";


    //TABLE INFORMATION
    private static final String taskId = "ID";
    private static final String taskTitle= "TITLE";
    private static final String taskNote= "NOTE";
    private static final String taskDueDate = "DATE";
    private static final String taskPriorityLevel = "PRIORITY";
    private static final String taskCollaborators = "COLLABORATOR";
    private static final String taskStatus = "STATUS";
    private static final String taskGroupId = "GROUPID";
    private SQLiteDatabase mydatabase;



    private TaskDaoImpl(Context context){
        super(context,DATABASE_NAME, null,DATABASE_VERSION);
        this.context = context;
    }

    public static TaskDaoImpl getInstance(Context ctx){
        if(instance == null){
            instance = new TaskDaoImpl(ctx);
            instance.tasks = new ArrayList<Task>();
            instance.createTableIfNotExist();
            Log.v("TaskDaoImpl: ", "getInstance() active");

        }
        return instance;
    }
    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        String create_db = "CREATE TABLE " + TABLE_TASK + "(" +
                taskId + " INTEGER PRIMARY KEY, "+
                taskTitle +" TEXT, "+
                taskNote + " TEXT, "+
                taskDueDate +" INTEGER, "+
                taskPriorityLevel +" INTEGER, "+
                taskCollaborators + " TEXT, "+
                taskStatus + " INTEGER, "+
                taskGroupId + " INTEGER"
                + ")";
        sqLiteDatabase.execSQL(create_db);
        Log.v("TaskDaoImpl", "Did create table " +TABLE_TASK);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i2) {
        onCreate(sqLiteDatabase);
    }

    public void createTableIfNotExist(){
        mydatabase = this.getWritableDatabase();
        String create_db = "CREATE TABLE IF NOT EXISTS " + TABLE_TASK + "(" +
                taskId + " INTEGER PRIMARY KEY, "+
                taskTitle +" TEXT, "+
                taskNote + " TEXT, "+
                taskDueDate +" INTEGER, "+
                taskPriorityLevel +" INTEGER, "+
                taskCollaborators + " TEXT, "+
                taskStatus + " INTEGER, "+
                taskGroupId + " INTEGER"
                + ")";
        mydatabase.execSQL(create_db);
    }
    @Override
    public ArrayList<Task> getAllTasks() {
        return tasks;
    }

    @Override
    public int createTask(Task task) {
        int maxID;
        if(tasks.isEmpty() == true){
            maxID = 0;
        } else {
            int id = tasks.get(tasks.size()-1).getId();
            maxID = id+1;
        }
        task.setId(maxID);
        tasks.add(task);
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put(taskId, task.getId());
        values.put(taskTitle, task.getTitle());
        values.put(taskNote, task.getNote());
        values.put(taskDueDate, task.getDueDate().getTime()/1000);
        values.put(taskPriorityLevel, task.getPriorityLevel());

        //collaborator from arraylist to String
        StringBuilder stringB = new StringBuilder();
        for (int i = 0; i < task.getCollaborator().size(); i++){
            stringB.append(task.getCollaborator().get(i));
            if (i < task.getCollaborator().size() -1){
                stringB.append(",");
            }
        }
        values.put(taskCollaborators, stringB.toString());
        values.put(taskStatus, task.isCompletionStatus());
        values.put(taskGroupId,task.getGroupID());

        db.insert(TABLE_TASK,null,values);
        db.close();
        return 1;
    }
    @Override
    public Task getTaskByID(int id) {
        for(int i = 0;i < tasks.size(); i++){
            if(tasks.get(i).getId() == id ){
                return tasks.get(i);
            }
        }
        return null;
    }
    public ArrayList<Task> getTaskByGroupID(int id){
        ArrayList<Task> filteredList = new ArrayList<Task>();
        for (int i = 0; i <tasks.size(); i++){
            if(tasks.get(i).getGroupID() == id){
                filteredList.add(tasks.get(i));
            }
        }
        return filteredList;
    }
    public void deleteTaskByGroupID(int groupID){
        for(int x = 0; x < tasks.size();x++){
            if(tasks.get(x).getGroupID() == groupID){
                deleteTask(tasks.get(x));
                x--;
            }
        }
    }
    @Override
    public int updateTask(Task task) {
        for (int i = 0; i< tasks.size();i++){
            if(tasks.get(i).getId() == task.getId()){
                tasks.get(i).setCollaborator(task.getCollaborator());
                tasks.get(i).setCompletionStatus(task.isCompletionStatus());
                tasks.get(i).setDueDate(task.getDueDate());
                tasks.get(i).setPriorityLevel(task.getPriorityLevel());
                tasks.get(i).setTitle(task.getTitle());
                tasks.get(i).setNote(task.getNote());
                return 1;
            }
        }
        return 0;
    }
    @Override
    public int deleteTask(Task task) {
        SQLiteDatabase db = this.getWritableDatabase();
        db.beginTransaction();
        db.delete(TABLE_TASK, taskId + " = ?", new String[] {String.valueOf(task.getId())});
        db.setTransactionSuccessful();
        db.endTransaction();
        Log.v("TaskDaoImpl: ", task.getId() + "-"+task.getTitle());
        tasks.remove(task);
        db.close();

        return 0;
    }

    public void init(){
        tasks.removeAll(tasks);
        Log.v("TaskDaoImpl: " , "init method");
        SQLiteDatabase db = this.getReadableDatabase();
        String query = "SELECT  * FROM " + TABLE_TASK;
        Cursor cursor = db.rawQuery(query, null);
        if(cursor.moveToFirst()){
            do{
                Task task = new Task();
                task.setId(Integer.parseInt(cursor.getString(0)));
                task.setTitle(cursor.getString(1));
                task.setNote(cursor.getString(2));
                Date datetime = new Date(Long.parseLong(cursor.getString(3)) * 1000);
                Log.v("datetime ", datetime.toString());
                task.setDueDate(datetime);

                task.setPriorityLevel(Integer.parseInt(cursor.getString(4)));
                //get collaborators
                String collaboratorsS = cursor.getString(5);
                ArrayList<String> colaList = new ArrayList<String>(Arrays.asList(collaboratorsS.split(",")));
                task.setCollaborator(colaList);
                //get status
                if(Integer.parseInt(cursor.getString(6)) == 0){
                    task.setCompletionStatus(false);
                } else {
                    task.setCompletionStatus(true);
                }
                //set group id
                task.setGroupID(Integer.parseInt(cursor.getString(7)));
                task.print();
                //add to array list - lists
                tasks.add(task);
            } while(cursor.moveToNext());
        }
    }
}
{% endhighlight %}

#ISSULE AND PROBLEM
In general, in order to use SQLiteHelper to make new table and database.
function named `onCreate(SQLiteDatabase db)` will be invoked to do that. In my
program, TaskGroupImpl instance is initialized before TaskDaoImpl, bug happend
here, when I make a new instance of TaskDaoImpl - ofcourse after TaskGroupImpl,
table named task would not be created or function named onCreate(SQLiteDatabase
db) is not invoked.

#Solution

I make an extra function to make new table manually. This function named
`createTableIfNotExist()`, it belong to `TaskDaoImpl class` - because it has a new
table which I want to make but not create automatically by SQLiteHelper.

When make call a instance of `TaskDaoImpl`, I also check to make a new table
name `task`. If it is exist, make no new table, if not, make a new table.

{% highlight java linenos %}
public void createTableIfNotExist(){
        mydatabase = this.getWritableDatabase();
        String create_db = "CREATE TABLE IF NOT EXISTS " + TABLE_TASK + "(" +
                taskId + " INTEGER PRIMARY KEY, "+
                taskTitle +" TEXT, "+
                taskNote + " TEXT, "+
                taskDueDate +" INTEGER, "+
                taskPriorityLevel +" INTEGER, "+
                taskCollaborators + " TEXT, "+
                taskStatus + " INTEGER, "+
                taskGroupId + " INTEGER"
                + ")";
        mydatabase.execSQL(create_db);
    }
{% endhighlight %}

In the contructor, I call this function to make a new table.
{% highlight java linenos %}
ublic static TaskDaoImpl getInstance(Context ctx){
        if(instance == null){
            instance = new TaskDaoImpl(ctx);
            instance.tasks = new ArrayList<Task>();
            instance.createTableIfNotExist();
            Log.v("TaskDaoImpl: ", "getInstance() active");

        }
        return instance;
    }
{% endhighlight %}
