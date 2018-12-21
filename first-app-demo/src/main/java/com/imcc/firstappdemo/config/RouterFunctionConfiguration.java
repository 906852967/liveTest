package com.imcc.firstappdemo.config;

import com.imcc.firstappdemo.domain.User;
import com.imcc.firstappdemo.repository.UserRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.server.RequestPredicates;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.RouterFunctions;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Flux;

import java.util.Collection;

//路由器函数配置
@Configuration
public class RouterFunctionConfiguration {
    //请求接口: ServletRequest 或者 HttpServletRequest
    //响应接口: ServletResponse 或者 HttpServletResponse
    //spring5 重新定义了服务请求和响应接口
    //请求接口: ServletRequest
    //响应接口: ServletResponse
    //Flux 是 0-N 个对象集合
    //Mono 是 0-1 个对象集合
    //Reactive 中的Flux或者Mono 是异步处理
    //集合基本上同步处理
    //Flux 或者 Mono 都是发布者
    @Bean
    public RouterFunction<ServerResponse> personfinalAll(UserRepository userRepository){


        RouterFunctions.route (RequestPredicates.GET ( "/person/find/all" ), request ->{
            Collection<User> users = userRepository.findAll();
            Flux<User> userFlux = Flux.fromIterable ( users );

            return ServerResponse.ok ().body ( userFlux, User.class );
        });
    }
}
