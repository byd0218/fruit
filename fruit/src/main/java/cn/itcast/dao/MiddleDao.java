package cn.itcast.dao;

import cn.itcast.domain.Middle;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MiddleDao {
    List<Middle> getByContractId(Integer contractId);
    void addMiddle(Middle middle);

    /**
     * 根据合同的contractid删除中间表中包含有要删除合同的相关信息
     * @param contractId
     */
    void delContract(Integer contractId);
}
