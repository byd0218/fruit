package cn.itcast.dao;

import cn.itcast.domain.Contract;
import cn.itcast.domain.ContractVo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ContractDao {
    public List<ContractVo> findAllContract(Map map);

    /**
     *根据合同的contractid删除合同
     * @param contractid
     */
    void delContract(Integer contractid);
    Contract getContractDetail(Integer contractid);
    List<Contract> getContractCommodities(Integer contractid);

    Contract getContractById(Integer contractId);
    void addOneContract(Contract contract);
    void editContract(Contract contract);

    List<Contract> isExitContract(Integer retailerid);

}
