package dao;

import java.util.ArrayList;

public interface DAO {

//    ArrayList<Object> do_search(String str);

    boolean do_insert(Object bean);

    boolean do_update(Object bean);

    boolean do_delete(Object bean);

    boolean do_upsert(Object bean);

    boolean do_detail(Object bean);
}
