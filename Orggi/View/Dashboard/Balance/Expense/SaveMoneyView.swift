//
//  SaveMoneyView.swift
//  Orggi
//
//  Created by Augusto Simionato on 06/12/23.
//

import SwiftUI

struct SaveMoneyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.green)
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                        .frame(height: 170)
                    
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                }
                
                Text("How To Save More Money")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                Text("Learn how to implement new habits to save your money")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.bottom, 15)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                SavingsStepView(step: "Estabeleça Metas Financeiras", description: "Defina metas claras e realistas para o curto, médio e longo prazo.")
                SavingsStepView(step: "Elabore um Orçamento", description: "Crie um orçamento detalhado para entender onde seu dinheiro está sendo gasto.")
                SavingsStepView(step: "Priorize Necessidades Sobre Desejos", description: "Diferencie entre necessidades e desejos. Priorize as despesas essenciais e corte gastos desnecessários.")
                SavingsStepView(step: "Reduza Despesas Fixas", description: "Analise suas despesas fixas, como contas de serviços públicos, assinaturas e planos de telefone.")
                SavingsStepView(step: "Construa um Fundo de Emergência", description: "Reserve uma parte do seu salário para um fundo de emergência.")
                SavingsStepView(step: "Evite Dívidas Desnecessárias", description: "Evite contrair dívidas para financiar compras supérfluas.")
                SavingsStepView(step: "Automatize suas Economias", description: "Configure transferências automáticas para uma conta de poupança assim que receber seu salário.")
                SavingsStepView(step: "Pesquise e Compare Preços", description: "Antes de fazer compras, pesquise e compare preços.")
                SavingsStepView(step: "Invista em Educação Financeira", description: "Aprenda sobre investimentos e estratégias para fazer seu dinheiro trabalhar para você.")
                SavingsStepView(step: "Revise Regularmente suas Finanças", description: "Periodicamente, reveja seu orçamento e faça ajustes conforme necessário.")
            }
            .padding()
        }
    }
}

struct SavingsStepView: View {
    var step: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(step)
                .font(.title3)
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    SaveMoneyView()
}
