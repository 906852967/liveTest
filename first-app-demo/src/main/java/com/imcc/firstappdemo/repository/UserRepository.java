package com.imcc.firstappdemo.repository;

import com.imcc.firstappdemo.domain.User;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.atomic.AtomicInteger;

@Repository
public class UserRepository {
    //采用内存型的存储方式
    private final ConcurrentMap<Integer, User> repository = new ConcurrentHashMap<> ( );
    private final static AtomicInteger idGenerator = new AtomicInteger ( );
    //如果保存成功, 返回ture
    public boolean save(User user){
//        boolean success = false;
        //ID从1开始
        Integer id = idGenerator.incrementAndGet ();
        user.setId ( id );
        return repository.put ( id, user ) == null;

    }

    public Collection<User> findAll() {
        return null;
    }
}
