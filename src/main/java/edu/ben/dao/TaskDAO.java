package edu.ben.dao;

import edu.ben.model.Task;

import java.util.List;

public interface TaskDAO {
    public void delete(int id);

    public void saveOrUpdate(Task task);

    public void create(Task task);

    public List getAllTasks();

    public Task getAllTasksByTaskID(int id);
}
